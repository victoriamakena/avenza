<template>
  <div class="page-container">
    <PageHeader
      title="Learning Content"
      subtitle="Manage financial education content for Avenza users."
    >
      <template #actions>
        <v-btn
          color="primary"
          @click="openCreate"
        >
          <v-icon start>
            mdi-plus
          </v-icon>

          Add lesson
        </v-btn>
      </template>
    </PageHeader>

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
        <div class="table-wrapper">
          <v-data-table
            :headers="headers"
            :items="lessons"
            :loading="loading"
          >
            <template #item.actions="{ item }">
              <v-btn
                icon="mdi-pencil-outline"
                variant="text"
                size="small"
                @click="openEdit(item)"
              />

              <v-btn
                icon="mdi-delete-outline"
                variant="text"
                size="small"
                color="error"
                @click="openDelete(item)"
              />
            </template>

            <template #no-data>
              <EmptyState
                title="No lessons yet"
                message="Create your first financial education lesson."
                icon="mdi-school-outline"
              />
            </template>
          </v-data-table>
        </div>
      </v-card-text>
    </v-card>

    <!-- CREATE / EDIT -->
    <v-dialog
      v-model="dialog"
      max-width="600"
    >
      <v-card>
        <v-card-title>
          {{ editing ? 'Edit lesson' : 'Add lesson' }}
        </v-card-title>

        <v-card-text>
          <v-text-field
            v-model="form.title"
            label="Title"
            class="mb-3"
          />

          <v-textarea
            v-model="form.content"
            label="Content"
            rows="6"
          />
        </v-card-text>

        <v-card-actions class="pa-4">
          <v-spacer />

          <v-btn
            variant="text"
            @click="dialog = false"
          >
            Cancel
          </v-btn>

          <v-btn
            color="primary"
            :loading="saving"
            @click="saveLesson"
          >
            Save
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>

    <ConfirmDialog
      v-model="deleteDialog"
      title="Delete lesson?"
      message="This lesson will be permanently removed."
      confirm-text="Delete"
      @confirm="deleteLesson"
    />
  </div>
</template>

<script setup>
import {
  onMounted,
  reactive,
  ref,
} from 'vue'

import PageHeader from '../components/PageHeader.vue'
import EmptyState from '../components/EmptyState.vue'
import ConfirmDialog from '../components/ConfirmDialog.vue'

import lessonService from '../services/lesson'

const lessons = ref([])
const loading = ref(false)
const saving = ref(false)

const dialog = ref(false)
const deleteDialog = ref(false)

const editing = ref(false)
const selectedLesson = ref(null)

const errorMessage = ref('')

const form = reactive({
  title: '',
  content: '',
})

const headers = [
  {
    title: 'Title',
    key: 'title',
  },
  {
    title: 'Content',
    key: 'content',
  },
  {
    title: 'Actions',
    key: 'actions',
    sortable: false,
  },
]

const resetForm = () => {
  form.title = ''
  form.content = ''
}

const loadLessons = async () => {
  loading.value = true

  try {
    const data =
      await lessonService.getLessons()

    lessons.value =
      data.lessons?.data ||
      data.data ||
      data
  } catch (error) {
    errorMessage.value =
      error.response?.data?.message ||
      'Unable to load lessons.'
  } finally {
    loading.value = false
  }
}

const openCreate = () => {
  editing.value = false
  selectedLesson.value = null

  resetForm()

  dialog.value = true
}

const openEdit = (lesson) => {
  editing.value = true
  selectedLesson.value = lesson

  form.title = lesson.title || ''
  form.content = lesson.content || ''

  dialog.value = true
}

const saveLesson = async () => {
  saving.value = true
  errorMessage.value = ''

  try {
    if (editing.value) {
      await lessonService.updateLesson(
        selectedLesson.value.id,
        form,
      )
    } else {
      await lessonService.createLesson(form)
    }

    dialog.value = false

    await loadLessons()
  } catch (error) {
    errorMessage.value =
      error.response?.data?.message ||
      'Unable to save lesson.'
  } finally {
    saving.value = false
  }
}

const openDelete = (lesson) => {
  selectedLesson.value = lesson

  deleteDialog.value = true
}

const deleteLesson = async () => {
  if (!selectedLesson.value) {
    return
  }

  try {
    await lessonService.deleteLesson(
      selectedLesson.value.id,
    )

    deleteDialog.value = false

    await loadLessons()
  } catch (error) {
    errorMessage.value =
      error.response?.data?.message ||
      'Unable to delete lesson.'
  }
}

onMounted(loadLessons)
</script>