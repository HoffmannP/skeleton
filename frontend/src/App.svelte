<script>
    import { FeatherIcon } from 'svelte-feather-icons'
    /* global isProduction */
    export let appname
    export const name = 'World'
    const status = isProduction
</script>

<main>
    <h1>{appname}: Hello {name} with <FeatherIcon /> {#if !status}[dev-mode]{/if}</h1>
</main>

<style>
h1 {
    color: darkblue;
}
</style>