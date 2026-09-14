import axios from 'axios'

const api = axios.create({
  baseURL: import.meta.env.VITE_API_BASE_URL || 'http://localhost:8000/api',
  headers: {
    Accept: 'application/json',
  },
})

// Attach the saved token to every request, if we have one.
api.interceptors.request.use((config) => {
  const token = localStorage.getItem('avenza_token')

  if (token) {
    config.headers.Authorization = `Bearer ${token}`
  }

  return config
})

// If the backend says our token is invalid/expired, clean up and send to login.
api.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response?.status === 401) {
      localStorage.removeItem('avenza_token')

      if (window.location.pathname !== '/login') {
        window.location.href = '/login'
      }
    }

    return Promise.reject(error)
  },
)

export default api