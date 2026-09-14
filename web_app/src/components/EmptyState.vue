<template>
  <div class="empty-state">
    <v-icon
      :icon="icon"
      size="56"
      color="grey"
      class="mb-4"
    />

    <h3 class="text-h6 mb-2">
      {{ title }}
    </h3>

    <p class="text-medium-emphasis mb-4">
      {{ message }}
    </p>

    <slot />
  </div>
</template>

<script setup>
defineProps({
  title: {
    type: String,
    default: 'No data found',
  },

  message: {
    type: String,
    default: 'There is nothing to display yet.',
  },

  icon: {
    type: String,
    default: 'mdi-information-outline',
  },
})
</script>