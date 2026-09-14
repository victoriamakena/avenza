<template>
  <div class="login-page">
    <v-card class="login-card pa-6 pa-sm-8">
      <div class="text-center mb-7">
        <v-avatar
          color="primary"
          size="52"
          class="mb-4"
        >
          <span class="text-white text-h5 font-weight-bold">
            A
          </span>
        </v-avatar>

        <h1 class="text-h5 font-weight-bold">
          Reset your password
        </h1>

        <p class="text-body-2 text-medium-emphasis">
          Avenza Admin Portal
        </p>
      </div>

      <v-alert
        v-if="successMessage"
        type="success"
        variant="tonal"
        class="mb-5"
      >
        {{ successMessage }}
      </v-alert>

      <v-alert
        v-if="errorMessage"
        type="error"
        variant="tonal"
        class="mb-5"
      >
        {{ errorMessage }}
      </v-alert>

      <p class="text-body-2 text-medium-emphasis mb-5">
        Enter your email address and we'll send you
        instructions to reset your password.
      </p>

      <v-form @submit.prevent="submit">
        <v-text-field
          v-model="email"
          label="Email address"
          type="email"
          prepend-inner-icon="mdi-email-outline"
          autocomplete="email"
          required
          class="mb-4"
        />

        <v-btn
          type="submit"
          color="primary"
          block
          size="large"
          :loading="loading"
        >
          Send reset link
        </v-btn>
      </v-form>

      <div class="text-center mt-5">
        <v-btn
          variant="text"
          to="/login"
        >
          <v-icon start>
            mdi-arrow-left
          </v-icon>

          Back to login
        </v-btn>
      </div>
    </v-card>
  </div>
</template>

<script setup>
import { ref } from 'vue'

import { useAuthStore } from '../stores/auth'

const email = ref('')

const loading = ref(false)
const successMessage = ref('')
const errorMessage = ref('')
const authStore = useAuthStore()

const submit = async () => {
  successMessage.value = ''
  errorMessage.value = ''

  if (!email.value) {
    errorMessage.value =
      'Please enter your email address.'

    return
  }

  loading.value = true

  try {
    await authStore.forgotPassword(email.value)
    successMessage.value =
      'If an account exists for that email, password reset instructions have been sent.'
  } catch (error) {
    errorMessage.value =
      error.response?.data?.message ||
      'Unable to process the request. Please try again.'
  } finally {
    loading.value = false
  }
}
</script>