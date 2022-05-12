<script>
    /* global isProduction */
    export const name = 'World'
    const status = isProduction
</script>

<main>
    <h1>Hello {name} {#if !status}[dev-mode]{/if}</h1>
</main>

<style>
h1 {
    color: darkblue;
}
</style>