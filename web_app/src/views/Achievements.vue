<template>
  <div class="page-container">
    <PageHeader
      title="Achievements"
      subtitle="Manage achievements that encourage healthy saving habits."
    >
      <template #actions>
        <v-btn
          color="primary"
          @click="openCreate"
        >
          <v-icon start>
            mdi-plus
          </v-icon>

          Add achievement
        </v-btn>
      </template>
    </PageHeader>

    <v-alert
      v-if="errorMessage"
      type="error"
      variant="tonal"
      class="mb-5"
    >
      {{ errorMessage }}
    </v-alert>

    <v-card>
      <v-card-text>
        <v-data-table
          :headers="headers"
          :items="achievements"
          :loading="loading"
        >
          <template #item.icon="{ item }">
            <v-icon>
              {{ item.icon || 'mdi-trophy-outline' }}
            </v-icon>
          </template>

          <template #item.actions="{ item }">
            <v-btn
              icon="mdi-pencil-outline"
              variant="text"
              size="small"
              @click="openEdit(item)"
            />

             <v-btn
                icon="mdi-delete-outline"
                variant="text"
                size="small"
                color="error"
                @click="openDelete(item)"
              />
          </template>

          <template #no-data>
            <EmptyState
              title="No achievements yet"
              message="Create achievements to encourage positive saving behavior."
              icon="mdi-trophy-outline"
            />
          </template>
        </v-data-table>
      </v-card-text>
    </v-card>

    <v-dialog
      v-model="dialog"
      max-width="600"
    >
      <v-card>
        <v-card-title>
          {{
            editing
              ? 'Edit achievement'
              : 'Add achievement'
          }}
        </v-card-title>

        <v-card-text>
          <v-text-field
            v-model="form.name"
            label="Name"
            class="mb-3"
          />

          <v-textarea
            v-model="form.description"
            label="Description"
            rows="4"
            class="mb-3"
          />

          <v-text-field
            v-model="form.icon"
            label="Icon"
            placeholder="mdi-trophy-outline"
            class="mb-3"
          />

          <v-text-field
            v-model.number="form.xp_reward"
            label="XP reward"
            type="number"
            min="0"
            class="mb-3"
          />

          <v-text-field
            v-model.number="form.points_reward"
            label="Points reward"
            type="number"
            min="0"
            class="mb-3"
          />

          <v-select
            v-model="form.criteria_type"
            label="Unlocks when..."
            :items="[
              { title: 'Total amount saved reaches', value: 'total_saved' },
              { title: 'Number of savings made reaches', value: 'savings_count' },
              { title: 'Goals completed reaches', value: 'goals_completed' },
              { title: 'Lessons completed reaches', value: 'lessons_completed' },
              { title: 'Saving streak reaches', value: 'streak_days' },
            ]"
            class="mb-3"
          />

          <v-text-field
            v-model.number="form.criteria_value"
            label="Target value"
            type="number"
            min="1"
          />
        </v-card-text>

        <v-card-actions class="pa-4">
          <v-spacer />

          <v-btn
            variant="text"
            @click="dialog = false"
          >
            Cancel
          </v-btn>

          <v-btn
            color="primary"
            :loading="saving"
            @click="saveAchievement"
          >
            Save
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
    <ConfirmDialog
        v-model="deleteDialog"
        title="Delete achievement?"
        message="This achievement will be permanently removed from view."
        confirm-text="Delete"
        @confirm="deleteAchievement"
      />
  </div>
</template>

<script setup>
import {
  onMounted,
  reactive,
  ref,
} from 'vue'

import PageHeader from '../components/PageHeader.vue'
import EmptyState from '../components/EmptyState.vue'

import achievementService from '../services/achievement'
import ConfirmDialog from '../components/ConfirmDialog.vue'

const achievements = ref([])
const loading = ref(false)
const saving = ref(false)

const dialog = ref(false)
const deleteDialog = ref(false)
const editing = ref(false)

const selectedAchievement = ref(null)

const errorMessage = ref('')

const form = reactive({
  name: '',
  description: '',
  icon: 'mdi-trophy-outline',
  xp_reward: 25,
  points_reward: 10,
  criteria_type: 'total_saved',
  criteria_value: 1000,
})

const headers = [
  { title: 'Icon', key: 'icon', sortable: false },
  { title: 'Name', key: 'name' },
  { title: 'Description', key: 'description' },
  { title: 'Actions', key: 'actions', sortable: false },
]

const resetForm = () => {
  form.name = ''
  form.description = ''
  form.icon = 'mdi-trophy-outline'
  form.xp_reward = 25
  form.points_reward = 10
  form.criteria_type = 'total_saved'
  form.criteria_value = 1000
}

const slugify = (text) =>
  text
    .toLowerCase()
    .trim()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/(^-|-$)/g, '')

const loadAchievements = async () => {
  loading.value = true

  try {
    const data = await achievementService.getAchievements()
    achievements.value = data.achievements || data.data || data
  } catch (error) {
    errorMessage.value =
      error.response?.data?.message || 'Unable to load achievements.'
  } finally {
    loading.value = false
  }
}

const openCreate = () => {
  editing.value = false
  selectedAchievement.value = null

  resetForm()

  dialog.value = true
}

const openEdit = (achievement) => {
  editing.value = true
  selectedAchievement.value = achievement

  form.name = achievement.name || ''
  form.description = achievement.description || ''
  form.icon = achievement.icon || 'mdi-trophy-outline'
  form.xp_reward = achievement.xp_reward ?? 25
  form.points_reward = achievement.points_reward ?? 10
  form.criteria_type = achievement.criteria_type || 'total_saved'
  form.criteria_value = achievement.criteria_value ?? 1000

  dialog.value = true
}

  const openDelete = (achievement) => {
  selectedAchievement.value = achievement
  deleteDialog.value = true
}

    const deleteAchievement = async () => {
      if (!selectedAchievement.value) {
        return
      }

      try {
        await achievementService.deleteAchievement(selectedAchievement.value.id)

        deleteDialog.value = false

        await loadAchievements()
      } catch (error) {
        errorMessage.value =
          error.response?.data?.message || 'Unable to delete achievement.'
      }
    }

const saveAchievement = async () => {
  saving.value = true
  errorMessage.value = ''

  const payload = { ...form, slug: slugify(form.name) }

  try {
    if (editing.value) {
      await achievementService.updateAchievement(selectedAchievement.value.id, payload)
    } else {
      await achievementService.createAchievement(payload)
    }

    dialog.value = false

    await loadAchievements()
  } catch (error) {
    errorMessage.value =
      error.response?.data?.message || 'Unable to save achievement.'
  } finally {
    saving.value = false
  }
}

onMounted(loadAchievements)
</script>