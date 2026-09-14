import { defineStore } from 'pinia'
import api from '../services/api'

export const useAuthStore = defineStore('auth', {
  state: () => ({
    user: null,
    token: localStorage.getItem('avenza_token') || null,
  }),

  getters: {
    isAuthenticated: (state) => !!state.token,
    isAdmin: (state) => state.user?.role === 'admin',
  },

  actions: {
    async login(credentials) {
      const response = await api.post('/auth/login', credentials)

      this.token = response.data.token
      this.user = response.data.user

      localStorage.setItem('avenza_token', this.token)

      return response.data
    },

    async logout() {
      try {
        await api.post('/auth/logout')
      } finally {
        this.token = null
        this.user = null
        localStorage.removeItem('avenza_token')
      }
    },

    async fetchUser() {
      const response = await api.get('/auth/me')
      this.user = response.data.user

      return this.user
    },

    async forgotPassword(email) {
      const response = await api.post('/auth/forgot-password', { email })
      return response.data
    },

    async resetPassword(data) {
      const response = await api.post('/auth/reset-password', data)
      return response.data
    },
  },
})