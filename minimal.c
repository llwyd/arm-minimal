/* A very minimalist blinky program for the L432KC nucleo board
 * T.L. 2021
 * */

/* Volatile because these are memory registers */
static volatile unsigned int * rcc      = (unsigned int *)0x4002104C;
static volatile unsigned int * gpio_b   = (unsigned int *)0x48000400;
static volatile unsigned int * pin      = (unsigned int *)0x48000414;

/* Systick registers */
static volatile unsigned int * stk_ctrl     = (unsigned int *)0xE000E010;
static volatile unsigned int * stk_load     = (unsigned int *)0xE000E014;
static volatile unsigned int * stk_val      = (unsigned int *)0xE000E018;
static volatile unsigned int * stk_calib    = (unsigned int *)0xE000E01C;

static const unsigned int pin_num = 0x8;

static unsigned int counter = 0U;

__attribute__((section(".fastdata")))
void _sysTick( void )
{
    *pin ^= pin_num;
    counter++;
}

int main ( void )
{

    /* enable port b*/
    *rcc |=  0x2; 
    /* set gpio b to output */
    *gpio_b &= 0xFFFFFF3F;
    *gpio_b |= 0x40;

    /* Configure systick */
    /* Calibration Value from datasheet */
    *stk_calib |= 0x100270F;

    /* 500ms blink */
    *stk_load |= 0x1e8480;
    /* turn on interrupt */
    *stk_ctrl |= 0x7;

    asm("CPSIE IF");

    while(1);

    return 0;
}
