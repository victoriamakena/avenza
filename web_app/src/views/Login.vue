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
          Avenza
        </h1>

        <p class="text-body-2 text-medium-emphasis">
          Admin Portal
        </p>
      </div>

      <div class="mb-5">
        <h2 class="text-h6">
          Welcome back
        </h2>

        <p class="text-body-2 text-medium-emphasis">
          Sign in to continue to the admin portal.
        </p>
      </div>

      <v-alert
        v-if="errorMessage"
        type="error"
        variant="tonal"
        class="mb-5"
      >
        {{ errorMessage }}
      </v-alert>

      <v-form @submit.prevent="login">
        <v-text-field
          v-model="form.email"
          label="Email address"
          type="email"
          prepend-inner-icon="mdi-email-outline"
          autocomplete="email"
          :error-messages="errors.email"
          required
          class="mb-3"
        />

        <v-text-field
          v-model="form.password"
          label="Password"
          :type="showPassword ? 'text' : 'password'"
          prepend-inner-icon="mdi-lock-outline"
          :append-inner-icon="
            showPassword
              ? 'mdi-eye-off-outline'
              : 'mdi-eye-outline'
          "
          autocomplete="current-password"
          :error-messages="errors.password"
          @click:append-inner="
            showPassword = !showPassword
          "
          required
        />

        <div class="text-right mb-5">
          <v-btn
            variant="text"
            size="small"
            color="primary"
            to="/forgot-password"
          >
            Forgot password?
          </v-btn>
        </div>

        <v-btn
          type="submit"
          color="primary"
          block
          size="large"
          :loading="loading"
        >
          Sign in
        </v-btn>
      </v-form>
    </v-card>
  </div>
</template>

<script setup>
import { reactive, ref } from 'vue'
import { useRouter } from 'vue-router'

import { useAuthStore } from '../stores/authStore'

const router = useRouter()
const authStore = useAuthStore()

const loading = ref(false)
const showPassword = ref(false)
const errorMessage = ref('')

const form = reactive({
  email: '',
  password: '',
})

const errors = reactive({
  email: '',
  password: '',
})

const clearErrors = () => {
  errors.email = ''
  errors.password = ''
  errorMessage.value = ''
}

const login = async () => {
  clearErrors()

  if (!form.email) {
    errors.email = 'Email is required.'
  }

  if (!form.password) {
    errors.password = 'Password is required.'
  }

  if (errors.email || errors.password) {
    return
  }

  loading.value = true

  try {
    await authStore.login({
      email: form.email,
      password: form.password,
    })

    if (!authStore.isAdmin) {
      await authStore.logout()

      errorMessage.value =
        'Administrator access is required.'

      return
    }

    router.push('/admin')
  } catch (error) {
    errorMessage.value =
      error.response?.data?.message ||
      'Unable to sign in. Please check your credentials.'
  } finally {
    loading.value = false
  }
}
</script>