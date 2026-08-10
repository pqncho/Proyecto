import { createRouter, createWebHistory } from "vue-router"

import ArticlesPage from "../components/pages/ArticlesPage.vue"
import LoginPage from "../components/pages/LoginPage.vue"
import RegisterPage from "../components/pages/RegisterPage.vue"
import ProfilePage from "../components/pages/ProfilePage.vue"
import NewArticlePage from "../components/pages/NewArticlePage.vue"
import EditArticlePage from "../components/pages/EditArticlePage.vue"
import AdminPage from "../components/pages/AdminPage.vue"

const routes = [

  {
    path: "/",
    component: ArticlesPage
  },

  {
    path: "/login",
    component: LoginPage
  },

  {
    path: "/register",
    component: RegisterPage
  },

  {
    path: "/profile",
    component: ProfilePage
  },

  {
    path: "/articles/new",
    component: NewArticlePage
  },
  {
    path: "/articles/:id/edit",
    component: EditArticlePage
  },
  {

    path: "/admin",
  component: AdminPage
  }

]


const router = createRouter({
  history: createWebHistory(),
  routes
})


export default router