<template>
    <div class="container">
        <h1>Listado de Productos segun su catalogo </h1>
        <div class="input-group mb-2">
            Filtro 1 - Seleccionar Catalogo:</div>
        <div class="input-group mb-2">
            <select class="form-select form-select-lg mb-3" aria-label=".form-select-lg" v-model="itemCatalogo.id"
                @change="getProductos(itemCatalogo.id)">
                <option v-for="item in catalogo" v-bind:key="item.id" v-bind:value="item.id">{{ item.nombre }}</option>
            </select>
        </div>


        <h2>Listado de Productos</h2>
        <br />
        <table class="table">
            <thead class="thead-light">
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">PRODUCTO</th>
                    <th scope="col">DESCRIPCION</th>
                    <th scope="col">PRECIO</th>                    
                </tr>
            </thead>
            <tbody>
                <tr v-for="(value, index) in productos">
                    <th scope="row">{{value.id}}</th>
                    <td>{{value.nombre}}</td>
                    <td>{{value.descripcion}}</td>
                    <td>{{value.precio}}</td>
                  
                </tr>

            </tbody>
        </table>

        <br /><br />
        
            <h1>Filtro 2 - Productos mayores a 100
            </h1>
        

        <br />

        <div class="accordion" id="accordionExample">

            <div class="accordion-item" v-for="(value, index) in filtrarPorPrecio">
                <h2 class="accordion-header" id="headingTwo">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                        :data-bs-target="`#collapseTwo${index}`" aria-expanded="false"
                        :aria-controls="`collapseTwo${index}`">
                        {{value.nombre}} - Precio: {{value.precio}}
                    </button>
                </h2>
                <div :id="`collapseTwo${index}`" class="accordion-collapse collapse" aria-labelledby="headingTwo"
                    data-bs-parent="#accordionExample">
                    <div class="accordion-body">
                        {{value.descripcion}}

                    </div>
                </div>
            </div>

        </div>
        <br/><br/><br/>
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
            precioFiltro: null,
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
        filtrarPorPrecio() {

            return this.productosTodo.filter(item => {
                return item.precio > 100
            });


        },
    },

    mounted() {
        this.getCatalogo();
        this.getAllProductos();
    },
    components: {
    }
}
</script>

<style>

</style>