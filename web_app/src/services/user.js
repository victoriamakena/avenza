import api from './api'

export default {
  async getUsers() {
    const response = await api.get(
      '/admin/users',
    )

    return response.data
  },

  async getUser(id) {
    const response = await api.get(
      `/admin/users/${id}`,
    )

    return response.data
  },

  async updateUser(id, data) {
    const response = await api.put(
      `/admin/users/${id}`,
      data,
    )

    return response.data
  },
}