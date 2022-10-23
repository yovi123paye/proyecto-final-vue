<template>
    <div class="container">
        Listado de Productos segun su catalogo
        <div class="input-group mb-2">
            Filtro 1 - Seleccionar Catalogo:</div>
        <div class="input-group mb-2">
            <select class="form-select form-select-lg mb-3" aria-label=".form-select-lg" v-model="itemCatalogo.id"
                @change="getProductos(itemCatalogo.id)">
                <option v-for="item in catalogo" v-bind:key="item.id" v-bind:value="item.id">{{ item.nombre }}</option>
            </select>
        </div>

        <div class="input-group mb-2">
            Filtro 2 - Colocar el precio:</div>
        <br />
        <h2>Listado de Productos</h2>
        <br />
        <table class="table">
            <thead class="thead-light">
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">PRODUCTO</th>
                    <th scope="col">DESCRIPCION</th>
                    <th scope="col">PRECIO</th>
                    <th scope="col">EDITAR</th>
                    <th scope="col">ELIMINAR</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="(value, index) in productos">
                    <th scope="row">{{value.id}}</th>
                    <td>{{value.nombre}}</td>
                    <td>{{value.descripcion}}</td>
                    <td>{{value.precio}}</td>
                    <td>
                        <a href="#" class="nav-link" @click="verProducto(value.id)"> <i
                                class="fa-sharp fa-solid fa-pen"></i> Editar</a>
                    </td>
                    <td>
                        <a href="#" class="nav-link" @click="eliminarProducto(value.id)"> <i
                                class="fa-sharp fa-solid fa-trash"></i>Eliminar </a>
                    </td>
                </tr>

            </tbody>
        </table>
    </div>
</template>

<script>
export default {
    name: 'filtroProductosView',
    data() {
        return {
            catalogo: [],
            productos: [],
            productosTodo: [],
            itemCatalogo: {
                id: null,
                nombre: null
            }
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
        
        getProductos(itemCatalogo) {
            axios({
                method: "get",
                // url: process.env.VUE_APP_RUTA_API+"/tareas/?q="+this.textoABuscar
                url: "http://localhost:3000/catalogo/" + itemCatalogo + "/productos",
            })
                .then(response => {
                    this.productos = response.data;
                    console.log(response);
                })
                .catch(e => console.log(e));
        },
        getAllProductos() {
            axios({
                method: "get",
                // url: process.env.VUE_APP_RUTA_API+"/tareas/?q="+this.textoABuscar
                url: "http://localhost:3000/productos",
            })
                .then(response => {
                    this.productosTodo = response.data;
                    console.log(response);
                })
                .catch(e => console.log(e));
        },        
    },
    
    computed: {
        filtrarPorPrecio(){
            if(this.$store.state.soloTerminado){
                return this.tareas.filter(item =>{
                    return item.terminado;
                });
            }
            return this.tareas;
        }
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