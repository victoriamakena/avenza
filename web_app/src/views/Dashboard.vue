<template>
  <div class="page-container">
    <PageHeader
      title="Dashboard"
      subtitle="Overview of the Avenza platform."
    />

    <v-alert
      v-if="errorMessage"
      type="error"
      variant="tonal"
      class="mb-6"
    >
      {{ errorMessage }}
    </v-alert>

    <v-row>
      <v-col
        cols="12"
        sm="6"
        lg="4"
      >
        <StatCard
          label="Total Users"
          :value="statistics.total_users"
          icon="mdi-account-group-outline"
          color="primary"
        />
      </v-col>

      <v-col
        cols="12"
        sm="6"
        lg="4"
      >
        <StatCard
          label="Verified Users"
          :value="statistics.verified_users"
          icon="mdi-account-check-outline"
          color="success"
        />
      </v-col>

      <v-col
        cols="12"
        sm="6"
        lg="4"
      >
        <StatCard
          label="Total Administrators"
          :value="statistics.total_admins"
          icon="mdi-shield-account-outline"
          color="accent"
        />
      </v-col>
    </v-row>

    <v-card class="mt-6 pa-6">
      <h2 class="text-h6 mb-2">
        Welcome to Avenza Administration
      </h2>

      <p class="text-body-2 text-medium-emphasis">
        Use the navigation menu to manage users,
        savings goals, learning content, achievements,
        rewards and redemption requests.
      </p>
    </v-card>
  </div>
</template>

<script setup>
import { onMounted, reactive, ref } from 'vue'

import StatCard from '../components/StatCard.vue'
import PageHeader from '../components/PageHeader.vue'

import dashboardService from '../services/dashboardService'

const loading = ref(false)
const errorMessage = ref('')

const statistics = reactive({
  total_users: 0,
  total_admins: 0,
  verified_users: 0,
})

const loadDashboard = async () => {
  loading.value = true
  errorMessage.value = ''

  try {
    const data =
      await dashboardService.getDashboard()

    Object.assign(
      statistics,
      data.statistics || {},
    )
  } catch (error) {
    errorMessage.value =
      error.response?.data?.message ||
      'Unable to load dashboard data.'
  } finally {
    loading.value = false
  }
}

onMounted(loadDashboard)
</script>