<script>
    import { FeatherIcon } from 'svelte-feather-icons'
    import Router from 'svelte-spa-router'
    import { wrap } from 'svelte-spa-router/wrap'

    /* global isProduction */
    export let appname
    export const name = 'World'
    const status = isProduction

    const globalProp = component => wrap({ component, props: {
        // backend = 'http://localhost:5001/api/v1'
    }})
  
    const routes = {
        '*': globalProp(NotFound)
    }
</script>

<main>
    <h1>{appname}: Hello {name} with <FeatherIcon /> {#if !status}[dev-mode]{/if}</h1>
    <Router/>
</main>

<style>
h1 {
    color: darkblue;
}
</style>