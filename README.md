```
git submodule add https://github.com/EloiStree/2026_09_11_gdp_text_uart_in_out_db.git addons/2026_09_11_gdp_text_uart_in_out_db
```

# 2026_09_11_gdp_text_uart_in_out_db
  
> Listen to UART input and register the value while keeping track of the device address.   

**Text:**    
When you work with adults who know how to code, you use bytes.    
But when you work with learners or kids, they use text and no code node.   
Like in [Bluetooth Electronics](https://github.com/EloiStree/2026_09_08_gdp_bluetooth_electronics_as_graph_node).  

**Native:**    
I hate having native code in my application:   
* Because it kills the open-source philosophy, as they all have pay-to-use licenses.   
* They are either for PC or Android, but never both. (Not counting Apple and Linux.)  

So my solution here is to have a text input gate and a text output gate in my app.   
Those gates know how to relay this information in and out.   
This add-on interacts between those gates.  

**GOMI:**   
Note that my app, GOMI, uses the `command line` to work, but here MicroBit and HC05 are more about dealing with data than commands.   
So using `cmd` to parse the incoming input is a bit out of scope.   
    
I have a format called `AB Input` format for merging all the inputs into a common trigger, boolean, or analog input entry.   
But UART input needs a bit of parsing to be valid in the key-value format.      

So this add-on tries to work on those topics.   

----------

Find here some python code to read and write UART to your Micro:bit :    
https://github.com/EloiStree/2026_09_11_python_micro_bit_hub      

