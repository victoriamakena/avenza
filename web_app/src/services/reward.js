import api from './api'

export default {
  async getRewards() {
    const response = await api.get(
      '/admin/rewards',
    )

    return response.data
  },

  async createReward(data) {
    const response = await api.post(
      '/admin/rewards',
      data,
    )

    return response.data
  },

  async updateReward(id, data) {
    const response = await api.put(
      `/admin/rewards/${id}`,
      data,
    )

    return response.data
  },

  async deleteReward(id) {
    const response = await api.delete(
      `/admin/rewards/${id}`,
    )

    return response.data
  },

  async getRedemptions() {
    const response = await api.get(
      '/admin/redemptions',
    )

    return response.data
  },

  async updateRedemption(id, data) {
    const response = await api.put(
      `/admin/redemptions/${id}`,
      data,
    )

    return response.data
  },
}