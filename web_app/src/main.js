import { createApp } from 'vue'
import { createPinia } from 'pinia'
import { createVuetify } from 'vuetify'
import { aliases, mdi } from 'vuetify/iconsets/mdi'

import 'vuetify/styles'
import '@mdi/font/css/materialdesignicons.css'

import App from './App.vue'
import router from './router'
import './assets/main.css'

const vuetify = createVuetify({
  icons: {
    defaultSet: 'mdi',
    aliases,
    sets: {
      mdi,
    },
  },

  theme: {
    defaultTheme: 'avenza',

    themes: {
      avenza: {
        dark: false,

        colors: {
          primary: '#1E3A8A',
          secondary: '#10B981',
          accent: '#FBBF24',

          background: '#F9FAFB',
          surface: '#FFFFFF',

          success: '#10B981',
          warning: '#F59E0B',
          error: '#DC2626',
          info: '#2563EB',

          'on-primary': '#FFFFFF',
          'on-secondary': '#FFFFFF',
          'on-background': '#111827',
          'on-surface': '#111827',
        },
      },
    },
  },

  defaults: {
    VBtn: {
      rounded: 'lg',
      elevation: 0,
    },

    VCard: {
      rounded: 'xl',
      elevation: 1,
    },

    VTextField: {
      variant: 'outlined',
      density: 'comfortable',
    },

    VSelect: {
      variant: 'outlined',
      density: 'comfortable',
    },

    VTextarea: {
      variant: 'outlined',
      density: 'comfortable',
    },
  },
})

const app = createApp(App)

app.use(createPinia())
app.use(router)
app.use(vuetify)

app.mount('#app')