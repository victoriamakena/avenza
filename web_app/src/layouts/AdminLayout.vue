<template>
  <v-dialog
    :model-value="modelValue"
    max-width="430"
    @update:model-value="$emit('update:modelValue', $event)"
  >
    <v-card>
      <v-card-title class="text-h6">
        {{ title }}
      </v-card-title>

      <v-card-text>
        {{ message }}
      </v-card-text>

      <v-card-actions class="pa-4">
        <v-spacer />

        <v-btn
          variant="text"
          @click="$emit('update:modelValue', false)"
        >
          Cancel
        </v-btn>

        <v-btn
          color="error"
          @click="$emit('confirm')"
        >
          {{ confirmText }}
        </v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script setup>
defineProps({
  modelValue: {
    type: Boolean,
    default: false,
  },

  title: {
    type: String,
    default: 'Confirm action',
  },

  message: {
    type: String,
    default: 'Are you sure?',
  },

  confirmText: {
    type: String,
    default: 'Confirm',
  },
})

defineEmits([
  'update:modelValue',
  'confirm',
])
</script>