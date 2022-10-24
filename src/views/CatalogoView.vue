<template>


    <div class="container">
        <img alt="Vue logo" style="max-width: 200px;" class="img-fluid" src="../assets/material.jpg">
        <div>
            <h1>Registro de Catalogo
            </h1>
        </div>
        <br />

        <div>
            <form @submit.prevent="agregarCatalogo()">

                <div class="input-group mb-2">
                    <input type="text" class="form-control" v-model="itemCatalogo.nombre"
                        placeholder="Nombre de Catalogo" aria-describedby="button-addon2">
                </div>
                <div class="input-group mb-2">
                    <button class="btn btn-outline-secondary" type="submit"><i class="fas fa-save"></i>Guardar</button>
                </div>
            </form>
        </div>

        <br />
        <br />
        <br />

        <div>
            <i class="el el-align-left">
                <p>
                    <label>Buscar por nombre :</label>
                    <input type="text"  v-model = "nombreCatalogo">
                    <button @click.prevent="getSeacrh()"><i class="fa-solid fa-magnifying-glass"></i></button>
                </p>
            </i>
        </div>
        <h1> Listado de Catalogo</h1>
        <table class="table">
            <thead class="thead-light">
                <tr>
                    <th scope="col">No.</th>
                    <th scope="col">CATEGORIA</th>
                    <th scope="col">EDITAR</th>
                    <th scope="col">ELIMINAR</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="(value, index) in catalogo">
                    <th scope="row">{{value.id}}</th>
                    <td>{{value.nombre}}</td>
                    <td>
                        <a href="#" class="nav-link" @click="verCatalogo(value.id)"> <i
                                class="fa-sharp fa-solid fa-pen"></i> Editar</a>
                    </td>
                    <td>
                        <a href="#" class="nav-link" @click="eliminarCatalogo(value.id)"> <i
                                class="fa-sharp fa-solid fa-trash"></i>Eliminar </a>
                    </td>
                </tr>

            </tbody>
        </table>

    </div>
</template>

<script>
export default {
    name: 'catologoView',
    data() {
        return {
            itemCatalogo: {
                id: null,
                nombre: null,
            },
            catalogo: [],
        }
    },
    methods: {
        nuevoCatalogo() {
            this.itemCatalogo = {
                id: null,
                nombre: null,
            };
        },
        verCatalogo(id) {
            axios({
                method: "get",

                url: "http://localhost:3000/catalogo/" + id
            })
                .then(response => {
                    console.log(response);
                    //this.tarea.titulo = null;
                    this.itemCatalogo = response.data;
                })
                .catch(e => console.log(e));
        },
        getSeacrh() {
            axios({
                method: "get",
                url: "http://localhost:3000/catalogo/?q="+this.nombreCatalogo
            })
                .then(response => {
                    this.catalogo = response.data;
                    console.log(response);
                })
                .catch(e => console.log(e));
        },
        getCatalogo() {
            axios({
                method: "get",

                url: "http://localhost:3000/catalogo",
            })
                .then(response => {
                    this.catalogo = response.data;
                    console.log(response);
                })
                .catch(e => console.log(e));
        },
        eliminarCatalogo(id) {
            axios({
                method: "delete",

                url: "http://localhost:3000/catalogo/" + id
            })
                .then(response => {
                    console.log(response);
                    this.getCatalogo();
                    this.nuevoCatalogo();
                })
                .catch(e => console.log(e));
        },
        agregarCatalogo() {
            if (this.itemCatalogo.id == null) {
                axios({
                    method: "post",

                    url: "http://localhost:3000/catalogo",
                    data: this.itemCatalogo
                })
                    .then(response => {
                        console.log(response);
                        this.getCatalogo();
                        this.nuevoCatalogo();
                    })
                    .catch(e => console.log(e));

            } else {
                axios({
                    method: "patch",
                    url: "http://localhost:3000/catalogo/" + this.itemCatalogo.id,
                    data: this.itemCatalogo
                })
                    .then(response => {
                        console.log(response);
                        this.getCatalogo();
                        this.nuevoCatalogo();
                    })
                    .catch(e => console.log(e));
            }



        },
    },
    computed: {
    },
    mounted() {
        this.getCatalogo();
    },
    components: {
    }
}
</script>

<style>

</style>