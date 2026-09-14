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

const achievements = ref([])
const loading = ref(false)
const saving = ref(false)

const dialog = ref(false)
const editing = ref(false)

const selectedAchievement = ref(null)

const errorMessage = ref('')

const form = reactive({
  name: '',
  description: '',
  icon: 'mdi-trophy-outline',
})

const headers = [
  {
    title: 'Icon',
    key: 'icon',
    sortable: false,
  },
  {
    title: 'Name',
    key: 'name',
  },
  {
    title: 'Description',
    key: 'description',
  },
  {
    title: 'Actions',
    key: 'actions',
    sortable: false,
  },
]

const resetForm = () => {
  form.name = ''
  form.description = ''
  form.icon = 'mdi-trophy-outline'
}

const loadAchievements = async () => {
  loading.value = true

  try {
    const data =
      await achievementService.getAchievements()

    achievements.value =
      data.achievements ||
      data.data ||
      data
  } catch (error) {
    errorMessage.value =
      error.response?.data?.message ||
      'Unable to load achievements.'
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
  form.description =
    achievement.description || ''
  form.icon =
    achievement.icon ||
    'mdi-trophy-outline'

  dialog.value = true
}

const saveAchievement = async () => {
  saving.value = true
  errorMessage.value = ''

  try {
    if (editing.value) {
      await achievementService.updateAchievement(
        selectedAchievement.value.id,
        form,
      )
    } else {
      await achievementService.createAchievement(
        form,
      )
    }

    dialog.value = false

    await loadAchievements()
  } catch (error) {
    errorMessage.value =
      error.response?.data?.message ||
      'Unable to save achievement.'
  } finally {
    saving.value = false
  }
}

onMounted(loadAchievements)
</script>