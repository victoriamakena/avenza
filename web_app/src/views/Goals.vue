<template>
  <div class="page-container">
    <PageHeader
      title="Savings Goals"
      subtitle="Monitor goals created by Avenza users."
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
        <v-text-field
          v-model="search"
          label="Search goals"
          prepend-inner-icon="mdi-magnify"
          clearable
          hide-details
          class="mb-4"
        />

        <div class="table-wrapper">
          <v-data-table
            :headers="headers"
            :items="goals"
            :search="search"
            :loading="loading"
            item-value="id"
          >
            <template #item.target_amount="{ item }">
              {{ item.target_amount ?? 0 }}
            </template>

            <template #item.current_amount="{ item }">
              {{ item.current_amount ?? 0 }}
            </template>

            <template #item.status="{ item }">
              <v-chip
                size="small"
                variant="tonal"
              >
                {{ item.status || 'Active' }}
              </v-chip>
            </template>

            <template #item.actions="{ item }">
              <v-btn
                icon="mdi-eye-outline"
                variant="text"
                size="small"
                :to="`/admin/goals/${item.id}`"
                aria-label="View goal"
              />
            </template>

            <template #no-data>
              <EmptyState
                title="No goals found"
                message="There are currently no savings goals to display."
                icon="mdi-bullseye-arrow"
              />
            </template>
          </v-data-table>
        </div>
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

import goalService from '../services/goal'

const goals = ref([])
const search = ref('')
const loading = ref(false)
const errorMessage = ref('')

const headers = [
  {
    title: 'Goal',
    key: 'name',
  },
  {
    title: 'User',
    key: 'user.name',
  },
  {
    title: 'Target',
    key: 'target_amount',
  },
  {
    title: 'Saved',
    key: 'current_amount',
  },
  {
    title: 'Status',
    key: 'status',
  },
  {
    title: 'Actions',
    key: 'actions',
    sortable: false,
  },
]

const loadGoals = async () => {
  loading.value = true

  try {
    const data =
      await goalService.getGoals()

    goals.value =
      data.goals?.data ||
      data.data ||
      data
  } catch (error) {
    errorMessage.value =
      error.response?.data?.message ||
      'Unable to load savings goals.'
  } finally {
    loading.value = false
  }
}

onMounted(loadGoals)
</script>