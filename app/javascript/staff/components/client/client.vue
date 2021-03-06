<template lang="pug">
  #edit-client
    h5.q-my-md Main info
    .form-wrapper.q-py-md
      q-form
        .row.q-col-gutter-lg
          .col-xs-12.col-sm-6.col-md-4
            q-input(
              filled
              v-model.trim="client.fullname"
              label="Full name"
              hint="Client name and surname"
              lazy-rules
              :rules="[ val => val && val.length >= 5 || 'Please press something']"
              ref="fullname"
            )
          .col-xs-12.col-sm-6.col-md-4
            q-input(
              filled
              v-model.trim="client.phone"
              label="Phone"
              hint="Client phone"
              lazy-rules
              :rules="[ val => val && val.length >= 6 && isFinite(val) || 'Please press number']"
              ref="phone"
            )
          .col-xs-12.col-sm-6.col-md-4
            q-input(
              filled
              v-model.trim="client.email"
              label="Email"
              hint="Client email"
              type="email"
              lazy-rules
              :rules="[emailRule]"
              ref="email"
            )
        .text-subtitle1.q-my-md Add relations
        .row.q-col-gutter-lg
          .col-xs-12.col-sm-6.col-md-6
            q-select(
              filled
              multiple
              v-model="organizationsSelected"
              label="Organization"
              hint="Select organization"
              :options="organizations"
              option-value="id"
              option-label="name"
            )
        .row.justify-center.q-pt-lg
          q-btn(
            outline
            @click="updateClient"
            label="Submit"
            :ripple="false"
            :loading="submitting"
          )
    password(:id="id")
</template>

<script>
  import Password from "./password.vue"
  import { backend } from '../../../api/index'

  let reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,})$/

  export default {
    data() {
      return {
        submitting: false,
        client: {},
        organizations: [],
        organizationsSelected: []
      }
    },
    computed: {
      id() {
        return this.$route.params.id
      },
      organizationIds() {
        return this.organizationsSelected.map(({ id }) => id)
      }
    },
    watch: {
      client() {
        this.organizationsSelected = this.client.organizations
      }
    },
    created() {
      this.fetchClient()
      this.fetchOrganizations()
    },
    methods: {
      fetchClient() {
        backend.staff.showClient(this.id)
          .then(({ data }) => this.client = data)
      },
      fetchOrganizations() {
        backend.staff.organizations()
          .then(({ data }) => this.organizations = data)
          .catch(error => console.log(error))
      },
      emailRule(val) {
        return new Promise((resolve, reject) => {
          resolve((reg.test(val) !== false) || 'Please press email')
        })
      },
      updateClient() {
        this.submitting = true

        this.$refs.fullname.validate()
        this.$refs.phone.validate()
        this.$refs.email.validate()

        if (this.$refs.fullname.hasError || this.$refs.phone.hasError || this.$refs.email.hasError) {
          this.formHasError = true
          this.submitting = false
        } else {
          backend.staff.updateClient({
              id: this.id,
              fullname: this.client.fullname,
              email: this.client.email,
              phone: this.client.phone,
              organization_ids: this.organizationIds
            })
            .then(() => {
              this.fetchClient()
              this.submitting = false
            })
            .catch(error => {
              console.log(error)
              this.submitting = false
            })
        }
      }
    },
    components: {
      Password
    }
  }
</script>

<style lang="stylus">

</style>
