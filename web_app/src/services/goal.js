import api from './api'

export default {
  async getGoals() {
    const response = await api.get(
      '/admin/goals',
    )

    return response.data
  },

  async getGoal(id) {
    const response = await api.get(
      `/admin/goals/${id}`,
    )

    return response.data
  },
}