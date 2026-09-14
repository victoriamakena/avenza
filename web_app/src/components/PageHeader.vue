<template>
  <div
    class="d-flex flex-column flex-sm-row justify-space-between align-start align-sm-center ga-4 mb-6"
  >
    <div>
      <h1 class="page-title">
        {{ title }}
      </h1>

      <p
        v-if="subtitle"
        class="page-subtitle mb-0"
      >
        {{ subtitle }}
      </p>
    </div>

    <div>
      <slot name="actions" />
    </div>
  </div>
</template>

<script setup>
defineProps({
  title: {
    type: String,
    required: true,
  },

  subtitle: {
    type: String,
    default: '',
  },
})
</script>