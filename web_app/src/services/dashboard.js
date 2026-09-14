import api from './api'

export default {
  async getDashboard() {
    const response = await api.get(
      '/dashboard',
    )

    return response.data
  },
}