import api from './api'

export default {
  async login(credentials) {
    const response = await api.post('/auth/login', credentials)
    return response.data
  },

  async logout() {
    const response = await api.post('/auth/logout')
    return response.data
  },

  async getCurrentUser() {
    const response = await api.get('/auth/me')
    return response.data
  },

  async forgotPassword(email) {
    const response = await api.post('/auth/forgot-password', {
      email,
    })

    return response.data
  },

  async resetPassword(data) {
    const response = await api.post('/auth/reset-password', data)
    return response.data
  },
}