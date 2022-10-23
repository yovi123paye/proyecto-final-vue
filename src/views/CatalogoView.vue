<template>
    <div>
        <h1>Catalogo
        </h1>
    </div>
    <div class="container">
        <table class="table">
            <thead class="thead-light">
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">CATEGORIA</th>         
                    <th scope="col">ACCION</th>           
                </tr>
            </thead>
            <tbody>
                <tr v-for="(value, index) in catalogo">
                    <th scope="row">{{value.id}}</th>
                    <td>{{value.nombre}}</td>                    
                    <td>                        

                    </td>
                </tr>

            </tbody>
        </table>

    </div>
</template>

<script>
    export default {
        name: 'catologoView',
        data(){
            return {
                catalogo: [],
            }
        },
        methods: {
            getCatalogo() {
            axios({
                method: "get",
                // url: process.env.VUE_APP_RUTA_API+"/tareas/?q="+this.textoABuscar
                url: "http://localhost:3000/catalogo",
            })
                .then(response => {
                    this.catalogo = response.data;
                    console.log(response);
                })
                .catch(e => console.log(e));
        },
        },
        computed: {
        },
        mounted(){
            this.getCatalogo();
        },
        components: {
        }
    }
</script>

<style>

</style>