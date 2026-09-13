<template>
  <div class="page-container">
    <PageHeader
      title="Redemptions"
      subtitle="Monitor reward redemption requests."
    />

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
          :items="redemptions"
          :loading="loading"
        >
          <template #item.user.name="{ item }">
            {{ item.user?.name || 'Unknown' }}
          </template>

          <template #item.reward.name="{ item }">
            {{ item.reward?.name || 'Unknown' }}
          </template>

          <template #item.status="{ item }">
            <v-chip
              :color="statusColor(item.status)"
              size="small"
              variant="tonal"
            >
              {{ item.status }}
            </v-chip>
          </template>

          <template #item.actions="{ item }">
            <v-menu>
              <template #activator="{ props }">
                <v-btn
                  v-bind="props"
                  variant="outlined"
                  size="small"
                >
                  Update status
                  <v-icon end>
                    mdi-chevron-down
                  </v-icon>
                </v-btn>
              </template>

              <v-list>
                <v-list-item
                  title="Pending"
                  @click="
                    updateStatus(item, 'pending')
                  "
                />

                <v-list-item
                  title="Approved"
                  @click="
                    updateStatus(item, 'approved')
                  "
                />

                <v-list-item
                  title="Rejected"
                  @click="
                    updateStatus(item, 'rejected')
                  "
                />

                <v-list-item
                  title="Completed"
                  @click="
                    updateStatus(item, 'completed')
                  "
                />
              </v-list>
            </v-menu>
          </template>

          <template #no-data>
            <EmptyState
              title="No redemption requests"
              message="There are currently no reward redemption requests."
              icon="mdi-receipt-text-outline"
            />
          </template>
        </v-data-table>
      </v-card-text>
    </v-card>
  </div>
</template>

<script setup>
import {
  onMounted,
  ref,
} from 'vue'

import PageHeader from '../components/PageHeader.vue'
import EmptyState from '../components/EmptyState.vue'

import reward from '../services/reward'

const redemptions = ref([])

const loading = ref(false)
const errorMessage = ref('')

const headers = [
  {
    title: 'User',
    key: 'user.name',
  },
  {
    title: 'Reward',
    key: 'reward.name',
  },
  {
    title: 'Status',
    key: 'status',
  },
  {
    title: 'Requested',
    key: 'created_at',
  },
  {
    title: 'Actions',
    key: 'actions',
    sortable: false,
  },
]

const statusColor = (status) => {
  switch (status) {
    case 'approved':
      return 'success'

    case 'completed':
      return 'primary'

    case 'rejected':
      return 'error'

    default:
      return 'warning'
  }
}

const loadRedemptions = async () => {
  loading.value = true

  try {
    const data =
      await reward.getRedemptions()

    redemptions.value =
      data.redemptions ||
      data.data ||
      data
  } catch (error) {
    errorMessage.value =
      error.response?.data?.message ||
      'Unable to load redemptions.'
  } finally {
    loading.value = false
  }
}

const updateStatus = async (
  redemption,
  status,
) => {
  try {
    await rewardService.updateRedemption(
      redemption.id,
      { status },
    )

    await loadRedemptions()
  } catch (error) {
    errorMessage.value =
      error.response?.data?.message ||
      'Unable to update redemption.'
  }
}

onMounted(loadRedemptions)
</script>