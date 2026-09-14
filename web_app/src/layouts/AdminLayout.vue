<template>
     <v-app>
    <!-- Top App Bar with Toggle Button -->
    <v-app-bar elevation="1" color="primary">
      <v-app-bar-nav-icon @click="drawer = !drawer"></v-app-bar-nav-icon>
      <v-app-bar-title>Avenza Admin</v-app-bar-title>
    </v-app-bar>

    <!-- Navigation Drawer -->
    <!-- 1. "rounded-r-xl" gives it smooth rounded right edges -->
    <!-- 2. "v-model" handles the sliding entry and exit animation -->
    <v-navigation-drawer
      v-model="drawer"
      class="rounded-r-xl"
      color="primary"
      theme="dark"
    >
      <!-- 3. Logo Container replacing the old text titles -->
      <div class="pa-4 d-flex justify-center align-center">
        <v-img
          src="@/public/logo.png"
          alt="Avenza Logo"
          max-height="50"
          contain
        ></v-img>
      </div>

      <v-divider></v-divider>

      <v-list nav density="comfortable">
        <v-list-item to="/admin"prepend-icon="mdi-view-quilt"title="Dashboard"exact/>
        <v-list-item to="/admin/users"prepend-icon="mdi-account-cog"title="Users"/>
        <v-list-item to="/admin/goals"prepend-icon="mdi-bullseye-arrow"title="Goals"/>
        <v-list-item to="/admin/lessons"prepend-icon="mdi-school"title="Lessons"/>
        <v-list-item to="/admin/achievements"prepend-icon="mdi-star-circle"title="Achievements"/>
        <v-list-item to="/admin/rewards" prepend-icon="mdi-gift" title="Rewards"/>
        <v-list-item to="/admin/redemptions" prepend-icon="mdi-hand-coin" title="Redemptions"/>
      </v-list>

      <template #append>
        <div class="pa-3">
          <v-btn
            block
            variant="tonal"
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
    </v-app>
</template>

<script setup>
import { useRouter } from 'vue-router'
import { useAuthStore } from '../stores/auth'

const router = useRouter()
const authStore = useAuthStore()

const handleLogout = async () => {
  await authStore.logout()
  router.push('/login')
}
</script>