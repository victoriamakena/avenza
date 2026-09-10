import api from './api'

export default {
  async getLessons() {
    const response = await api.get(
      '/admin/lessons',
    )

    return response.data
  },

  async createLesson(data) {
    const response = await api.post(
      '/admin/lessons',
      data,
    )

    return response.data
  },

  async updateLesson(id, data) {
    const response = await api.put(
      `/admin/lessons/${id}`,
      data,
    )

    return response.data
  },

  async deleteLesson(id) {
    const response = await api.delete(
      `/admin/lessons/${id}`,
    )

    return response.data
  },
}