flowchart LR
    A[station_install]
    B[fwcm_main]
    C[fwcv_load_lang]
    subgraph s_sd[Set Defaults]
    D[fwcv_set_default_removes]
    E[fwvu_greet_user\n Define message]
    F[fwvu_get_default_removes]
    end
    subgraph s_iv[Input Validation]
    G[fwcv_validate_user_input]
    I[fwcv_validation_controller]
    K[fwcv_validate_choices]
    J[fwvu_retry_prompt]
    end
    
    subgraph s_qr[Quit Routine]
    H[fwcv_check_quit]
    L[fwcv_verify_quit]
    M[fwvu_verify_quit]
    N[fwvu_exit]
    O[fwvu_no_quit]
    end
    subgraph s_or[Output Routine]
    P[fwvu_output]
    Q[fwvu_msg]
    R[fwvu_prompt]
    end

    A -- Bootstrap --> B
    B -- Load language file --> C
    B -- Define default tools\nuser does not\nwant installed --> D
    D -- 1. Greet user --> E
    D -- 3. Send input through\nvalidation routine --> G
    E -- Send to\nbuffer --> s_or
    P -- Place message\nin buffer --> Q
    P -- Called if\nprompting user --> R
    D -- 2. Generate default\ntools message\n& Prompt --> F
    F -- Send to\nbuffer --> s_or
    G -- Check if user\nwants to quit --> H
    H -- If quit detected --> L
    L -- Ask user if sure --> M
    M -- Prompt --> s_or
    N -- Send to\nbuffer --> s_or
    L -- Confirmed\nDefine goodbye message --> N
    L -- Redirect process back to caller --> O
    G --> I
    I --> K
    G -- If validation fails --> J
    J --> s_or
