```mermaid
flowchart TD
    subgraoph Controller
    A[station_install] --> B[fwcm_main]
    subgraph View Controller
    B --> C[fwcv_load_lang]
    B --> D[fwcv_set_default_removes]
    D --> G[fwcv_validate_user_input]
    G --> H[fwcv_check_quit] 
    G --> I[fwcv_validation_controller] 
    I --> K[fwcv_validate_choices]
    H --> L[fwcv_verify_quit]
    end
    end
    subgraph View User
    D --> E[fwvu_greet_user] 
    D --> F[fwvu_get_default_removes]
    G --> J[fwvu_retry_prompt]
    L --> M[fwvu_verify_quit] 
    L --> N[fwvu_exit]
    L --> O[fwvu_no_quit]
    E --> P[fwvu_output]
    P --> Q[fwvu_msg] 
    P --> R[fwvu_prompt]
    end
    F --> P
    J --> P
    O --> P
    N --> P  
```
