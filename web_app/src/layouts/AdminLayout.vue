<template>
  <v-app-bar
    elevation="1"
    color="primary"
  >
    <v-app-bar-nav-icon @click="drawer = !drawer" />
    <v-app-bar-title>Avenza Admin</v-app-bar-title>
  </v-app-bar>

  <v-navigation-drawer
    v-model="drawer"
    class="rounded-r-xl"
    color="primary"
    theme="light"
  >
    <div class="pa-4 d-flex justify-center align-center">
      <v-img
        src="/logo.png"
        alt="Avenza Logo"
        max-height="50"
        contain
      />
    </div>

    <v-divider />

    <v-list nav density="comfortable">
      <v-list-item
        to="/admin"
        prepend-icon="mdi-view-quilt"
        title="Dashboard"
        active-color="secondary"
        exact
      />
      <v-list-item
        to="/admin/users"
        prepend-icon="mdi-account-cog"
        title="Users"
        active-color="secondary"
      />
      <v-list-item
        to="/admin/goals"
        prepend-icon="mdi-bullseye-arrow"
        title="Goals"
        active-color="secondary"
      />
      <v-list-item
        to="/admin/lessons"
        prepend-icon="mdi-school"
        title="Lessons"
        active-color="secondary"
      />
      <v-list-item
        to="/admin/achievements"
        prepend-icon="mdi-star-circle"
        title="Achievements"
        active-color="secondary"
      />
      <v-list-item
        to="/admin/rewards"
        prepend-icon="mdi-gift"
        title="Rewards"
        active-color="secondary"
      />
      <v-list-item
        to="/admin/redemptions"
        prepend-icon="mdi-hand-coin"
        title="Redemptions"
        active-color="secondary"
      />
    </v-list>

    <template #append>
      <div class="pa-3">
        <v-btn
          block
          variant="tonal"
          color="secondary"
          prepend-icon="mdi-logout"
          @click="handleLogout"
        >
          Log out
        </v-btn>
      </div>
    </template>
  </v-navigation-drawer>

  <v-main>
    <v-container>
      <router-view />
    </v-container>
  </v-main>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '../stores/auth'

const drawer = ref(true)

const router = useRouter()
const authStore = useAuthStore()

const handleLogout = async () => {
  await authStore.logout()
  router.push('/login')
}
</script>