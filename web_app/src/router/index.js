import {
  createRouter,
  createWebHistory,
} from 'vue-router'

import Login from '../views/Login.vue'
import ForgotPassword from '../views/ForgotPassword.vue'
import ResetPassword from '../views/ResetPassword.vue'

import Dashboard from '../views/Dashboard.vue'

import Users from '../views/Users.vue'
import UserDetails from '../views/UserDetails.vue'

import Goals from '../views/Goals.vue'
import GoalDetails from '../views/GoalDetails.vue'

import Lessons from '../views/Lessons.vue'
import Achievements from '../views/Achievements.vue'

import Rewards from '../views/Rewards.vue'
import Redemptions from '../views/Redemptions.vue'

import { useAuth } from '../stores/auth'

const routes = [
  {
    path: '/',
    redirect: '/admin',
  },

  {
    path: '/login',
    name: 'Login',
    component: Login,
  },

  {
    path: '/forgot-password',
    name: 'ForgotPassword',
    component: ForgotPassword,
  },

  {
    path: '/reset-password',
    name: 'ResetPassword',
    component: ResetPassword,
  },

  {
    path: '/admin',

    component: () =>
      import('../layouts/AdminLayout.vue'),

    meta: {
      requiresAuth: true,
      requiresAdmin: true,
    },

    children: [
      {
        path: '',
        name: 'Dashboard',
        component: Dashboard,
      },

      {
        path: 'users',
        name: 'Users',
        component: Users,
      },

      {
        path: 'users/:id',
        name: 'UserDetails',
        component: UserDetails,
      },

      {
        path: 'goals',
        name: 'Goals',
        component: Goals,
      },

      {
        path: 'goals/:id',
        name: 'GoalDetails',
        component: GoalDetails,
      },

      {
        path: 'lessons',
        name: 'Lessons',
        component: Lessons,
      },

      {
        path: 'achievements',
        name: 'Achievements',
        component: Achievements,
      },

      {
        path: 'rewards',
        name: 'Rewards',
        component: Rewards,
      },

      {
        path: 'redemptions',
        name: 'Redemptions',
        component: Redemptions,
      },
    ],
  },
]

const router = createRouter({
  history: createWebHistory(),
  routes,

  scrollBehavior() {
    return {
      top: 0,
    }
  },
})

router.beforeEach(async (to) => {
  const authStore = useAuth()

  if (
    to.meta.requiresAuth &&
    !authStore.isAuthenticated
  ) {
    return '/login'
  }

  if (
    to.meta.requiresAuth &&
    authStore.isAuthenticated &&
    !authStore.user
  ) {
    try {
      await authStore.fetchUser()
    } catch (error) {
      await authStore.logout()

      return '/login'
    }
  }

  if (
    to.meta.requiresAdmin &&
    !authStore.isAdmin
  ) {
    return '/login'
  }

  if (
    to.path === '/login' &&
    authStore.isAuthenticated &&
    authStore.isAdmin
  ) {
    return '/admin'
  }

  return true
})

export default router