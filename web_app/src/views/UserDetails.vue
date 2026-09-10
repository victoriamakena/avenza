<template>
  <div class="page-container">
    <PageHeader
      title="User Details"
      subtitle="View information about this Avenza user."
    >
      <template #actions>
        <v-btn
          variant="outlined"
          to="/admin/users"
        >
          <v-icon start>
            mdi-arrow-left
          </v-icon>

          Back to users
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
      v-if="user"
      class="pa-6"
    >
      <div class="d-flex align-center mb-6">
        <v-avatar
          color="primary"
          size="64"
        >
          <span class="text-white text-h6">
            {{ initials }}
          </span>
        </v-avatar>

        <div class="ml-4">
          <h2 class="text-h6">
            {{ user.name }}
          </h2>

          <p class="text-body-2 text-medium-emphasis mb-0">
            {{ user.email }}
          </p>
        </div>
      </div>

      <v-row>
        <v-col
          cols="12"
          md="6"
        >
          <div class="text-caption text-medium-emphasis">
            Role
          </div>

          <div class="font-weight-medium">
            {{ user.role }}
          </div>
        </v-col>

        <v-col
          cols="12"
          md="6"
        >
          <div class="text-caption text-medium-emphasis">
            Email verification
          </div>

          <v-chip
            :color="
              user.email_verified_at
                ? 'success'
                : 'warning'
            "
            size="small"
            variant="tonal"
            class="mt-1"
          >
            {{
              user.email_verified_at
                ? 'Verified'
                : 'Unverified'
            }}
          </v-chip>
        </v-col>

        <v-col
          cols="12"
          md="6"
        >
          <div class="text-caption text-medium-emphasis">
            XP
          </div>

          <div class="font-weight-medium">
            {{ user.xp ?? 0 }}
          </div>
        </v-col>

        <v-col
          cols="12"
          md="6"
        >
          <div class="text-caption text-medium-emphasis">
            Reward Points
          </div>

          <div class="font-weight-medium">
            {{ user.reward_points ?? 0 }}
          </div>
        </v-col>
      </v-row>
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

import userService from '../services/userService'

const route = useRoute()

const user = ref(null)
const loading = ref(false)
const errorMessage = ref('')

const initials = computed(() => {
  if (!user.value?.name) {
    return 'U'
  }

  return user.value.name
    .split(' ')
    .map((part) => part.charAt(0))
    .slice(0, 2)
    .join('')
    .toUpperCase()
})

const loadUser = async () => {
  loading.value = true

  try {
    const data =
      await userService.getUser(
        route.params.id,
      )

    user.value =
      data.user ||
      data
  } catch (error) {
    errorMessage.value =
      error.response?.data?.message ||
      'Unable to load user.'
  } finally {
    loading.value = false
  }
}

onMounted(loadUser)
</script>