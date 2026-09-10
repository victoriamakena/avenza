import api from './api'

export default {
  async getDashboard() {
    const response = await api.get(
      '/admin/dashboard',
    )

    return response.data
  },
}