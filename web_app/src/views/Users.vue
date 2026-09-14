<template>
  <div class="page-container">
    <PageHeader
      title="Users"
      subtitle="View and manage Avenza user accounts."
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
          label="Search users"
          prepend-inner-icon="mdi-magnify"
          clearable
          hide-details
          class="mb-4"
        />

        <div class="table-wrapper">
          <v-data-table
            :headers="headers"
            :items="users"
            :search="search"
            :loading="loading"
            item-value="id"
          >
            <template #item.name="{ item }">
              <div class="font-weight-medium">
                {{ item.name }}
              </div>
            </template>

            <template #item.email_verified_at="{ item }">
              <v-chip
                v-if="item.email_verified_at"
                color="success"
                size="small"
                variant="tonal"
              >
                Verified
              </v-chip>

              <v-chip
                v-else
                color="warning"
                size="small"
                variant="tonal"
              >
                Unverified
              </v-chip>
            </template>

            <template #item.role="{ item }">
              <v-chip
                :color="
                  item.role === 'admin'
                    ? 'primary'
                    : 'default'
                "
                size="small"
                variant="tonal"
              >
                {{ item.role }}
              </v-chip>
            </template>

            <template #item.actions="{ item }">
              <v-btn
                icon="mdi-eye-outline"
                variant="text"
                size="small"
                :to="`/admin/users/${item.id}`"
                aria-label="View user"
              />
            </template>

            <template #no-data>
              <EmptyState
                title="No users found"
                message="There are currently no users to display."
                icon="mdi-account-search-outline"
              />
            </template>
          </v-data-table>
        </div>
      </v-card-text>
    </v-card>
  </div>
</template>

<script setup>
import { onMounted, ref } from 'vue'

import PageHeader from '../components/PageHeader.vue'
import EmptyState from '../components/EmptyState.vue'

import userService from '../services/user'

const users = ref([])
const search = ref('')
const loading = ref(false)
const errorMessage = ref('')

const headers = [
  {
    title: 'Name',
    key: 'name',
  },
  {
    title: 'Email',
    key: 'email',
  },
  {
    title: 'Role',
    key: 'role',
  },
  {
    title: 'Verification',
    key: 'email_verified_at',
  },
  {
    title: 'Actions',
    key: 'actions',
    sortable: false,
  },
]

const loadUsers = async () => {
  loading.value = true
  errorMessage.value = ''

  try {
    const data =
      await userService.getUsers()

    users.value =
      data.users?.data ||
      data.data ||
      data
  } catch (error) {
    errorMessage.value =
      error.response?.data?.message ||
      'Unable to load users.'
  } finally {
    loading.value = false
  }
}

onMounted(loadUsers)
</script>