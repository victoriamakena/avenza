<template>
  <div class="page-container">
    <PageHeader
      title="Rewards"
      subtitle="Manage rewards available in the Avenza rewards economy."
    >
      <template #actions>
        <v-btn
          color="primary"
          @click="openCreate"
        >
          <v-icon start>
            mdi-plus
          </v-icon>

          Add reward
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
          :items="rewards"
          :loading="loading"
        >
          <template #item.points_cost="{ item }">
            {{ item.points_cost ?? 0 }}
          </template>

          <template #item.active="{ item }">
            <v-chip
              :color="
                item.active
                  ? 'success'
                  : 'default'
              "
              size="small"
              variant="tonal"
            >
              {{
                item.active
                  ? 'Active'
                  : 'Inactive'
              }}
            </v-chip>
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
              title="No rewards yet"
              message="Create rewards for the Avenza rewards store."
              icon="mdi-gift-outline"
            />
          </template>
        </v-data-table>
      </v-card-text>
    </v-card>

    <!-- FORM -->
    <v-dialog
      v-model="dialog"
      max-width="600"
    >
      <v-card>
        <v-card-title>
          {{
            editing
              ? 'Edit reward'
              : 'Add reward'
          }}
        </v-card-title>

        <v-card-text>
          <v-text-field
            v-model="form.name"
            label="Reward name"
            class="mb-3"
          />

          <v-textarea
            v-model="form.description"
            label="Description"
            rows="4"
            class="mb-3"
          />

          <v-text-field
            v-model.number="form.points_cost"
            label="Points cost"
            type="number"
            min="0"
            class="mb-3"
          />

          <v-switch
            v-model="form.active"
            label="Active"
            color="success"
            hide-details
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
            @click="saveReward"
          >
            Save
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>

    <ConfirmDialog
      v-model="deleteDialog"
      title="Delete reward?"
      message="This reward will be permanently removed."
      confirm-text="Delete"
      @confirm="deleteReward"
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
import ConfirmDialog from '../components/ConfirmDialog.vue'

import rewardService from '../services/reward'

const rewards = ref([])

const loading = ref(false)
const saving = ref(false)

const dialog = ref(false)
const deleteDialog = ref(false)

const editing = ref(false)

const selectedReward = ref(null)

const errorMessage = ref('')

const form = reactive({
  name: '',
  description: '',
  points_cost: 0,
  active: true,
})

const headers = [
  {
    title: 'Name',
    key: 'name',
  },
  {
    title: 'Description',
    key: 'description',
  },
  {
    title: 'Points',
    key: 'points_cost',
  },
  {
    title: 'Status',
    key: 'active',
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
  form.points_cost = 0
  form.active = true
}

const loadRewards = async () => {
  loading.value = true

  try {
    const data =
      await rewardService.getRewards()

    rewards.value =
      data.rewards ||
      data.data ||
      data
  } catch (error) {
    errorMessage.value =
      error.response?.data?.message ||
      'Unable to load rewards.'
  } finally {
    loading.value = false
  }
}

const openCreate = () => {
  editing.value = false
  selectedReward.value = null

  resetForm()

  dialog.value = true
}

const openEdit = (reward) => {
  editing.value = true
  selectedReward.value = reward

  form.name = reward.name || ''
  form.description =
    reward.description || ''
  form.points_cost =
    reward.points_cost ?? 0
  form.active =
    reward.active ?? true

  dialog.value = true
}

const saveReward = async () => {
  saving.value = true
  errorMessage.value = ''

  try {
    if (editing.value) {
      await rewardService.updateReward(
        selectedReward.value.id,
        form,
      )
    } else {
      await rewardService.createReward(form)
    }

    dialog.value = false

    await loadRewards()
  } catch (error) {
    errorMessage.value =
      error.response?.data?.message ||
      'Unable to save reward.'
  } finally {
    saving.value = false
  }
}

const openDelete = (reward) => {
  selectedReward.value = reward

  deleteDialog.value = true
}

const deleteReward = async () => {
  if (!selectedReward.value) {
    return
  }

  try {
    await rewardService.deleteReward(
      selectedReward.value.id,
    )

    deleteDialog.value = false

    await loadRewards()
  } catch (error) {
    errorMessage.value =
      error.response?.data?.message ||
      'Unable to delete reward.'
  }
}

onMounted(loadRewards)
</script>