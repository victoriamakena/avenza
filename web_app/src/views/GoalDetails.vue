<template>
  <div class="page-container">
    <PageHeader
      title="Goal Details"
      subtitle="View the details and progress of this savings goal."
    >
      <template #actions>
        <v-btn
          variant="outlined"
          to="/admin/goals"
        >
          <v-icon start>
            mdi-arrow-left
          </v-icon>

          Back to goals
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

    <v-card
      v-if="goal"
      class="pa-6"
    >
      <div class="d-flex justify-space-between align-start mb-5">
        <div>
          <h2 class="text-h6">
            {{ goal.name }}
          </h2>

          <p class="text-body-2 text-medium-emphasis">
            {{ goal.description || 'No description provided.' }}
          </p>
        </div>

        <v-chip variant="tonal">
          {{ goal.status || 'Active' }}
        </v-chip>
      </div>

      <v-row>
        <v-col
          cols="12"
          md="4"
        >
          <div class="text-caption text-medium-emphasis">
            Target amount
          </div>

          <div class="text-h6">
            {{ goal.target_amount ?? 0 }}
          </div>
        </v-col>

        <v-col
          cols="12"
          md="4"
        >
          <div class="text-caption text-medium-emphasis">
            Current amount
          </div>

          <div class="text-h6">
            {{ goal.current_amount ?? 0 }}
          </div>
        </v-col>

        <v-col
          cols="12"
          md="4"
        >
          <div class="text-caption text-medium-emphasis">
            User
          </div>

          <div class="text-h6">
            {{ goal.user?.name || 'Unknown' }}
          </div>
        </v-col>
      </v-row>

      <v-divider class="my-6" />

      <div class="text-subtitle-2 mb-2">
        Progress
      </div>

      <v-progress-linear
        :model-value="progress"
        color="secondary"
        height="10"
        rounded
      />

      <div class="text-caption text-medium-emphasis mt-2">
        {{ progress }}% complete
      </div>
    </v-card>

    <v-card
      v-else-if="loading"
      class="pa-8 text-center"
    >
      <v-progress-circular
        indeterminate
        color="primary"
      />
    </v-card>
  </div>
</template>

<script setup>
import {
  computed,
  onMounted,
  ref,
} from 'vue'

import { useRoute } from 'vue-router'

import PageHeader from '../components/PageHeader.vue'

import goalService from '../services/goal'

const route = useRoute()

const goal = ref(null)
const loading = ref(false)
const errorMessage = ref('')

const progress = computed(() => {
  const target =
    Number(goal.value?.target_amount) || 0

  const current =
    Number(goal.value?.current_amount) || 0

  if (!target) {
    return 0
  }

  return Math.min(
    100,
    Math.round((current / target) * 100),
  )
})

const loadGoal = async () => {
  loading.value = true

  try {
    const data =
      await goalService.getGoal(
        route.params.id,
      )

    goal.value =
      data.goal ||
      data
  } catch (error) {
    errorMessage.value =
      error.response?.data?.message ||
      'Unable to load goal.'
  } finally {
    loading.value = false
  }
}

onMounted(loadGoal)
</script>