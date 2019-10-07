import axios from 'axios'

let token = document.getElementsByName('csrf-token')[0].getAttribute('content');
axios.defaults.headers.common['X-CSRF-Token'] = token;
axios.defaults.headers.common['Accept'] = 'application/json';

const adapter = axios.create({
  baseURL: '/'
});

const backend = {
  client: {
    current: () => adapter.get('/clients/home/user')
  },
  staff: {
    current: () => adapter.get('/staffs/home/user'),
    clients: () => adapter.get('/staffs/clients'),
    staffs: () => adapter.get('/staffs/staffs'),
    createStaff: (params) => adapter.post('/staffs/staffs', params),
    showStaff: (id) => adapter.get(`/staffs/staffs/${id}`),
    updateStaff: (params) => adapter.patch(`/staffs/staffs/${params.id}`, params),
    updatePasswordStaff: (params) => adapter.patch(`staffs/staffs/${params.id}/reset_password`, params),
    createClient: (params) => adapter.post('/staffs/clients', params),
    showClient: (id) => adapter.get(`/staffs/clients/${id}`),
    updateClient: (params) => adapter.patch(`/staffs/clients/${params.id}`, params),
    updatePasswordClient: (params) => adapter.patch(`staffs/clients/${params.id}/reset_password`, params),
    forms: () => adapter.get('/staffs/forms'),
    organizations: () => adapter.get('/staffs/organizations'),
    createOrganizations: (params) => adapter.post('/staffs/organizations', params),
    deleteOrganizations: (id) => adapter.delete(`/staffs/organizations/${id}`),
    createClientsOrganizations: (params) => adapter.post('/staffs/clients_organizations', params)
  }
};

export { backend }
