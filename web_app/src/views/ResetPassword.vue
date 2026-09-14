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
          Create a new password
        </h1>

        <p class="text-body-2 text-medium-emphasis">
          Choose a secure password for your account.
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

      <v-form @submit.prevent="submit">
        <v-text-field
          v-model="form.password"
          label="New password"
          :type="
            showPassword
              ? 'text'
              : 'password'
          "
          prepend-inner-icon="mdi-lock-outline"
          :append-inner-icon="
            showPassword
              ? 'mdi-eye-off-outline'
              : 'mdi-eye-outline'
          "
          autocomplete="new-password"
          @click:append-inner="
            showPassword = !showPassword
          "
          required
          class="mb-3"
        />

        <v-text-field
          v-model="form.password_confirmation"
          label="Confirm password"
          :type="
            showPassword
              ? 'text'
              : 'password'
          "
          prepend-inner-icon="mdi-lock-check-outline"
          autocomplete="new-password"
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
          Reset password
        </v-btn>
      </v-form>

      <div class="text-center mt-5">
        <v-btn
          variant="text"
          to="/login"
        >
          Back to login
        </v-btn>
      </div>
    </v-card>
  </div>
</template>

<script setup>
import { reactive, ref } from 'vue'
import { useRoute,useRouter, } from 'vue-router'
import { useAuthStore } from '../stores/auth'

const authStore = useAuthStore()
const route = useRoute()
const router = useRouter()

const loading = ref(false)
const showPassword = ref(false)

const successMessage = ref('')
const errorMessage = ref('')

const form = reactive({
  token: route.query.token || '',
  email: route.query.email || '',
  password: '',
  password_confirmation: '',
})

const submit = async () => {
  successMessage.value = ''
  errorMessage.value = ''

  if (!form.token || !form.email) {
    errorMessage.value =
      'This password reset link is incomplete or invalid.'

    return
  }

  if (!form.password) {
    errorMessage.value =
      'Please enter a new password.'

    return
  }

  if (
    form.password !==
    form.password_confirmation
  ) {
    errorMessage.value =
      'The passwords do not match.'

    return
  }

  loading.value = true

  try {
    await authStore.resetPassword({
      token: form.token,
      email: form.email,
      password: form.password,
      password_confirmation:
        form.password_confirmation,
    })

    successMessage.value =
      'Your password has been updated successfully.'

    setTimeout(() => {
      router.push('/login')
    }, 1500)
  } catch (error) {
    errorMessage.value =
      error.response?.data?.message ||
      'Unable to reset your password. The link may have expired.'
  } finally {
    loading.value = false
  }
}
</script>