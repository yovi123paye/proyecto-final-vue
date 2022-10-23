<template>
    <div class="container">
        <h1>Productos</h1>
        <h4>{{mensaje}}</h4>
        <form @submit.prevent="agregarProducto()">
            <div class="input-group mb-2">
                <input type="text" class="form-control" v-model="producto.nombre" placeholder="Nuevo Producto"
                    aria-describedby="button-addon2">
            </div>
            <div class="input-group mb-2">
                <input type="text" class="form-control" v-model="producto.descripcion" placeholder="Descripcion"
                    aria-describedby="button-addon2">
            </div>
            <div class="input-group mb-2">
                <input type="text" class="form-control" v-model="producto.precio" placeholder="Precio"
                    aria-describedby="button-addon2">
            </div>
            <div class="input-group mb-2">
                <button class="btn btn-outline-secondary" type="submit">Agregar</button>
            </div>
            <!-- <div class="input-group mb-2">
                <button class="btn btn-outline-secondary" type="submit">Modificar</button>
            </div> -->

        </form>

        <h2>Listado de Productos</h2>
        <div class="accordion" id="accordionExample">
            <div class="accordion-item" v-for="(value, index) in productos">
                <h2 class="accordion-header" id="headingTwo">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                        :data-bs-target="`#collapseTwo${index}`" aria-expanded="false"
                        :aria-controls="`collapseTwo${index}`">
                        {{value.nombre}}
                    </button>
                </h2>
                <div :id="`collapseTwo${index}`" class="accordion-collapse collapse" aria-labelledby="headingTwo"
                    data-bs-parent="#accordionExample">
                    <div class="accordion-body">
                        {{value.descripcion}}

                        <!-- <app-acciones @onAccion="irA($event, value.id)"></app-acciones> -->

                    </div>
                </div>
            </div>

        </div>

        <div class="">

        </div>
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

        <!-- <div class="accordion" id="accordionExample">

            <div class="accordion-item" v-for="(value, index) in lista">
                <h2 class="accordion-header" id="headingTwo">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                        :data-bs-target="`#collapseTwo${index}`" aria-expanded="false"
                        :aria-controls="`collapseTwo${index}`">
                        <input type="checkbox" :checked="value.terminado"
                            @click="setearCheckbox(value.terminado, value.id)">
                        {{value.titulo}}
                    </button>
                </h2>
                <div :id="`collapseTwo${index}`" class="accordion-collapse collapse" aria-labelledby="headingTwo"
                    data-bs-parent="#accordionExample">
                    <div class="accordion-body">
                        {{value.contenido}}

                        <app-acciones @onAccion="irA($event, value.id)"></app-acciones>

                    </div>
                </div>
            </div>

        </div> -->


    </div>
</template>

<script>
//import AppAcciones from '@/components/AppAcciones.vue';
export default {
    name: 'productoView',
    data() {
        return {
            /*soloTeminado: false,
            textoABuscar: '',
            "id": 1,
            "imagen": "https://ae01.alicdn.com/kf/Sc3cc58f2a441419f970cc01f9e5358fbw/Dron-LU3-MAX-GPS-8K-HD-profesional-con-c-mara-Dual-card-n-autoestabilizador-Motor-sin.jpg_Q90.jpg_.webp",
            "nombre": "Cemento Viacha IPV 40",
            "descripcion": "ABC ....",
            "precio": "50",
            "catalogoId": 1
            */
            producto: {
                id: null,
                nombre: null,
                descripcion: null,
                precio: null,
                catalogoId: 1,
            },
            productos: [],
            mensaje: "hola Roberto",
        }
    },
    methods: {
        agregarProducto() {
            axios({
                method: "post",
                // url: process.env.VUE_APP_RUTA_API+"/tareas",
                url: "http://localhost:3000/productos",
                data: this.producto
            })
                .then(response => {
                    console.log(response);
                    //this.tarea.titulo = null;
                    this.getProductos();
                })
                .catch(e => console.log(e));
        },
        getProductos() {
            axios({
                method: "get",
                // url: process.env.VUE_APP_RUTA_API+"/tareas/?q="+this.textoABuscar
                url: "http://localhost:3000/productos",
            })
                .then(response => {
                    this.productos = response.data;
                    console.log(response);
                })
                .catch(e => console.log(e));
        },
        eliminarProducto(id) {
            axios({
                method: "delete",
                // url: process.env.VUE_APP_RUTA_API+"/tareas",
                url: "http://localhost:3000/productos/" + id
            })
                .then(response => {
                    console.log(response);
                    //this.tarea.titulo = null;
                    this.getProductos();
                })
                .catch(e => console.log(e));
        },
        verProducto(id) {
            axios({
                method: "get",
                // url: process.env.VUE_APP_RUTA_API+"/tareas",
                url: "http://localhost:3000/productos/" + id
            })
                .then(response => {
                    console.log(response);
                    //this.tarea.titulo = null;
                    this.producto = response.data;;
                })
                .catch(e => console.log(e));
        }

    },
    computed: {

    },
    mounted() {
        this.getProductos();
    },
    components: {

    }
}
</script>