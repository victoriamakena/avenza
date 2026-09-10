<template>
  <v-card class="stat-card pa-5">
    <div class="d-flex justify-space-between align-start">
      <div>
        <div class="stat-label">
          {{ label }}
        </div>

        <div class="stat-value">
          {{ value }}
        </div>

        <div
          v-if="subtitle"
          class="text-caption text-medium-emphasis mt-1"
        >
          {{ subtitle }}
        </div>
      </div>

      <v-avatar
        :color="color"
        size="44"
      >
        <v-icon
          :icon="icon"
          color="white"
        />
      </v-avatar>
    </div>
  </v-card>
</template>

<script setup>
defineProps({
  label: {
    type: String,
    required: true,
  },

  value: {
    type: [String, Number],
    default: 0,
  },

  subtitle: {
    type: String,
    default: '',
  },

  icon: {
    type: String,
    default: 'mdi-chart-box-outline',
  },

  color: {
    type: String,
    default: 'primary',
  },
})
</script>