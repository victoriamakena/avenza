import api from './api'

export default {
  async getAchievements() {
    const response = await api.get('/admin/achievements')
    return response.data
  },

  async createAchievement(data) {
    const response = await api.post('/admin/achievements', data)
    return response.data
  },

  async updateAchievement(id, data) {
    const response = await api.put(`/admin/achievements/${id}`, data)
    return response.data
  },

  async deleteAchievement(id) {
    const response = await api.delete(`/admin/achievements/${id}`)
    return response.data
  },
}