import {
  createRouter,
  createWebHistory,
} from 'vue-router'

import LoginView from '../views/LoginView.vue'
import ForgotPasswordView from '../views/ForgotPasswordView.vue'
import ResetPasswordView from '../views/ResetPasswordView.vue'

import DashboardView from '../views/DashboardView.vue'

import UsersView from '../views/UsersView.vue'
import UserDetailsView from '../views/UserDetailsView.vue'

import GoalsView from '../views/GoalsView.vue'
import GoalDetailsView from '../views/GoalDetailsView.vue'

import LessonsView from '../views/LessonsView.vue'
import AchievementsView from '../views/AchievementsView.vue'

import RewardsView from '../views/RewardsView.vue'
import RedemptionsView from '../views/RedemptionsView.vue'

import { useAuthStore } from '../stores/authStore'

const routes = [
  {
    path: '/',
    redirect: '/admin',
  },

  {
    path: '/login',
    name: 'Login',
    component: LoginView,
  },

  {
    path: '/forgot-password',
    name: 'ForgotPassword',
    component: ForgotPasswordView,
  },

  {
    path: '/reset-password',
    name: 'ResetPassword',
    component: ResetPasswordView,
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
        component: DashboardView,
      },

      {
        path: 'users',
        name: 'Users',
        component: UsersView,
      },

      {
        path: 'users/:id',
        name: 'UserDetails',
        component: UserDetailsView,
      },

      {
        path: 'goals',
        name: 'Goals',
        component: GoalsView,
      },

      {
        path: 'goals/:id',
        name: 'GoalDetails',
        component: GoalDetailsView,
      },

      {
        path: 'lessons',
        name: 'Lessons',
        component: LessonsView,
      },

      {
        path: 'achievements',
        name: 'Achievements',
        component: AchievementsView,
      },

      {
        path: 'rewards',
        name: 'Rewards',
        component: RewardsView,
      },

      {
        path: 'redemptions',
        name: 'Redemptions',
        component: RedemptionsView,
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
  const authStore = useAuthStore()

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