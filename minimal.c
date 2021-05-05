/* A very minimalist blinky program for the L432KC nucleo board
 * T.L. 2021
 * */

static volatile unsigned int * rcc      = (unsigned int *)0x4002104C;
static volatile unsigned int * gpio_b   = (unsigned int *)0x48000400;
static volatile unsigned int * pin      = (unsigned int *)0x48000414;

static volatile const unsigned int pin_num = 0x8;

volatile void _test(void)
{

}

int main ( void )
{

    /* enable port b*/
    *rcc |=  0x2;
    _test();
    /* set gpio b to output */
    *gpio_b &= 0xFFFFFF3F;
    *gpio_b |= 0x40;

    while(1)
    {
        *pin ^= pin_num;
        for( unsigned int i = 0; i < 50000; i++);
    }

    return 0;
}
