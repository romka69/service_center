<template lang="pug">
  #new-staff
    h5.text-bold.q-my-md Create new staff
    .form-wrapper.q-py-md
      q-form
        .row.q-col-gutter-lg
          .col-xs-12.col-sm-6
            q-input(
              filled
              v-model.trim="email"
              label="Email"
              hint="Staff email"
              type="email"
              lazy-rules
              :rules="[emailRule]"
              ref="email"
            )
          .col-xs-12.col-sm-6
            q-input(
              filled
              v-model.trim="password"
              label="Password"
              hint="Staff password (minimum 8 char)"
              lazy-rules
              :rules="[ val => val && val.length >= 8 || 'Please press password']"
              ref="password"
            )
        .row.justify-center.q-pt-lg
          q-btn(
            outline
            @click="sendStaff"
            label="Submit"
            :ripple="false"
            :loading="submitting"
          )
</template>

<script>
  import { backend } from '../../../api/index'

  let reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,})$/

  export default {
    data: function () {
      return {
        submitting: false,
        email: '',
        password: ''
      }
    },
    methods: {
      emailRule(val) {
        return new Promise((resolve, reject) => {
          resolve((reg.test(val) !== false) || 'Please press email')
        })
      },
      sendStaff() {
        this.submitting = true

        this.$refs.email.validate()
        this.$refs.password.validate()

        if (this.$refs.email.hasError || this.$refs.password.hasError) {
          this.formHasError = true
          this.submitting = false
        } else {
          backend.staff.createStaff({
            email: this.email,
            password: this.password
          })
            .then(response => {
              this.$emit('push-staff', response.data)
              this.submitting = false
            })
            .catch(error => {
              console.log(error)
              this.submitting = false
            })
        }
      }
    }
  }
</script>

<style lang="stylus">

</style>
