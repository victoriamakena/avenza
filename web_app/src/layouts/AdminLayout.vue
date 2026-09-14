<template>
  <v-app>
    <v-navigation-drawer
      permanent
      color="surface"
    >
      <v-list-item
        title="Avenza"
        subtitle="Admin Portal"
        class="py-4"
      />

      <v-divider />

      <v-list nav density="comfortable">
        <v-list-item
          to="/admin"
          prepend-icon="mdi-view-dashboard-outline"
          title="Dashboard"
          exact
        />
        <v-list-item
          to="/admin/users"
          prepend-icon="mdi-account-group-outline"
          title="Users"
        />
        <v-list-item
          to="/admin/goals"
          prepend-icon="mdi-flag-outline"
          title="Goals"
        />
        <v-list-item
          to="/admin/lessons"
          prepend-icon="mdi-book-open-outline"
          title="Lessons"
        />
        <v-list-item
          to="/admin/achievements"
          prepend-icon="mdi-medal-outline"
          title="Achievements"
        />
        <v-list-item
          to="/admin/rewards"
          prepend-icon="mdi-gift-outline"
          title="Rewards"
        />
        <v-list-item
          to="/admin/redemptions"
          prepend-icon="mdi-swap-horizontal"
          title="Redemptions"
        />
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
      <div class="pa-6">
        <router-view />
      </div>
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