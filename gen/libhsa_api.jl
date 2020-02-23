
function status_string(status::hsa_status_t, status_string::Ref{Cstring})
    ccall((:hsa_status_string, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_status_t, Ref{Cstring}), status, status_string)
end

function init()
    ccall((:hsa_init, Symbol("libhsa-runtime64")), hsa_status_t, ())
end

function shut_down()
    ccall((:hsa_shut_down, Symbol("libhsa-runtime64")), hsa_status_t, ())
end

function system_get_info(attribute::hsa_system_info_t, value::Ref{Cvoid})
    ccall((:hsa_system_get_info, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_system_info_t, Ref{Cvoid}), attribute, value)
end

function extension_get_name(extension::UInt16, name::Ref{Cstring})
    ccall((:hsa_extension_get_name, Symbol("libhsa-runtime64")), hsa_status_t, (UInt16, Ref{Cstring}), extension, name)
end

function system_extension_supported(extension::UInt16, version_major::UInt16, version_minor::UInt16, result::Ref{Bool})
    ccall((:hsa_system_extension_supported, Symbol("libhsa-runtime64")), hsa_status_t, (UInt16, UInt16, UInt16, Ref{Bool}), extension, version_major, version_minor, result)
end

function system_major_extension_supported(extension::UInt16, version_major::UInt16, version_minor::Ref{UInt16}, result::Ref{Bool})
    ccall((:hsa_system_major_extension_supported, Symbol("libhsa-runtime64")), hsa_status_t, (UInt16, UInt16, Ref{UInt16}, Ref{Bool}), extension, version_major, version_minor, result)
end

function system_get_extension_table(extension::UInt16, version_major::UInt16, version_minor::UInt16, table::Ref{Cvoid})
    ccall((:hsa_system_get_extension_table, Symbol("libhsa-runtime64")), hsa_status_t, (UInt16, UInt16, UInt16, Ref{Cvoid}), extension, version_major, version_minor, table)
end

function system_get_major_extension_table(extension::UInt16, version_major::UInt16, table_length::Csize_t, table::Ref{Cvoid})
    ccall((:hsa_system_get_major_extension_table, Symbol("libhsa-runtime64")), hsa_status_t, (UInt16, UInt16, Csize_t, Ref{Cvoid}), extension, version_major, table_length, table)
end

function agent_get_info(agent::hsa_agent_t, attribute::hsa_agent_info_t, value::Ref{Cvoid})
    ccall((:hsa_agent_get_info, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_agent_t, hsa_agent_info_t, Ref{Cvoid}), agent, attribute, value)
end

function iterate_agents(callback::Ref{Cvoid}, data::Ref{Cvoid})
    ccall((:hsa_iterate_agents, Symbol("libhsa-runtime64")), hsa_status_t, (Ref{Cvoid}, Ref{Cvoid}), callback, data)
end

function agent_get_exception_policies(agent::hsa_agent_t, profile::hsa_profile_t, mask::Ref{UInt16})
    ccall((:hsa_agent_get_exception_policies, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_agent_t, hsa_profile_t, Ref{UInt16}), agent, profile, mask)
end

function cache_get_info(cache::hsa_cache_t, attribute::hsa_cache_info_t, value::Ref{Cvoid})
    ccall((:hsa_cache_get_info, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_cache_t, hsa_cache_info_t, Ref{Cvoid}), cache, attribute, value)
end

function agent_iterate_caches(agent::hsa_agent_t, callback::Ref{Cvoid}, data::Ref{Cvoid})
    ccall((:hsa_agent_iterate_caches, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_agent_t, Ref{Cvoid}, Ref{Cvoid}), agent, callback, data)
end

function agent_extension_supported(extension::UInt16, agent::hsa_agent_t, version_major::UInt16, version_minor::UInt16, result::Ref{Bool})
    ccall((:hsa_agent_extension_supported, Symbol("libhsa-runtime64")), hsa_status_t, (UInt16, hsa_agent_t, UInt16, UInt16, Ref{Bool}), extension, agent, version_major, version_minor, result)
end

function agent_major_extension_supported(extension::UInt16, agent::hsa_agent_t, version_major::UInt16, version_minor::Ref{UInt16}, result::Ref{Bool})
    ccall((:hsa_agent_major_extension_supported, Symbol("libhsa-runtime64")), hsa_status_t, (UInt16, hsa_agent_t, UInt16, Ref{UInt16}, Ref{Bool}), extension, agent, version_major, version_minor, result)
end

function signal_create(initial_value::hsa_signal_value_t, num_consumers::UInt32, consumers::Ref{hsa_agent_t}, signal::Ref{hsa_signal_t})
    ccall((:hsa_signal_create, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_signal_value_t, UInt32, Ref{hsa_agent_t}, Ref{hsa_signal_t}), initial_value, num_consumers, consumers, signal)
end

function signal_destroy(signal::hsa_signal_t)
    ccall((:hsa_signal_destroy, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_signal_t,), signal)
end

function signal_load_scacquire(signal::hsa_signal_t)
    ccall((:hsa_signal_load_scacquire, Symbol("libhsa-runtime64")), hsa_signal_value_t, (hsa_signal_t,), signal)
end

function signal_load_relaxed(signal::hsa_signal_t)
    ccall((:hsa_signal_load_relaxed, Symbol("libhsa-runtime64")), hsa_signal_value_t, (hsa_signal_t,), signal)
end

function signal_load_acquire(signal::hsa_signal_t)
    ccall((:hsa_signal_load_acquire, Symbol("libhsa-runtime64")), hsa_signal_value_t, (hsa_signal_t,), signal)
end

function signal_store_relaxed(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_store_relaxed, Symbol("libhsa-runtime64")), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_store_screlease(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_store_screlease, Symbol("libhsa-runtime64")), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_store_release(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_store_release, Symbol("libhsa-runtime64")), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_silent_store_relaxed(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_silent_store_relaxed, Symbol("libhsa-runtime64")), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_silent_store_screlease(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_silent_store_screlease, Symbol("libhsa-runtime64")), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_exchange_scacq_screl(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_exchange_scacq_screl, Symbol("libhsa-runtime64")), hsa_signal_value_t, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_exchange_acq_rel(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_exchange_acq_rel, Symbol("libhsa-runtime64")), hsa_signal_value_t, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_exchange_scacquire(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_exchange_scacquire, Symbol("libhsa-runtime64")), hsa_signal_value_t, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_exchange_acquire(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_exchange_acquire, Symbol("libhsa-runtime64")), hsa_signal_value_t, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_exchange_relaxed(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_exchange_relaxed, Symbol("libhsa-runtime64")), hsa_signal_value_t, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_exchange_screlease(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_exchange_screlease, Symbol("libhsa-runtime64")), hsa_signal_value_t, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_exchange_release(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_exchange_release, Symbol("libhsa-runtime64")), hsa_signal_value_t, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_cas_scacq_screl(signal::hsa_signal_t, expected::hsa_signal_value_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_cas_scacq_screl, Symbol("libhsa-runtime64")), hsa_signal_value_t, (hsa_signal_t, hsa_signal_value_t, hsa_signal_value_t), signal, expected, value)
end

function signal_cas_acq_rel(signal::hsa_signal_t, expected::hsa_signal_value_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_cas_acq_rel, Symbol("libhsa-runtime64")), hsa_signal_value_t, (hsa_signal_t, hsa_signal_value_t, hsa_signal_value_t), signal, expected, value)
end

function signal_cas_scacquire(signal::hsa_signal_t, expected::hsa_signal_value_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_cas_scacquire, Symbol("libhsa-runtime64")), hsa_signal_value_t, (hsa_signal_t, hsa_signal_value_t, hsa_signal_value_t), signal, expected, value)
end

function signal_cas_acquire(signal::hsa_signal_t, expected::hsa_signal_value_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_cas_acquire, Symbol("libhsa-runtime64")), hsa_signal_value_t, (hsa_signal_t, hsa_signal_value_t, hsa_signal_value_t), signal, expected, value)
end

function signal_cas_relaxed(signal::hsa_signal_t, expected::hsa_signal_value_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_cas_relaxed, Symbol("libhsa-runtime64")), hsa_signal_value_t, (hsa_signal_t, hsa_signal_value_t, hsa_signal_value_t), signal, expected, value)
end

function signal_cas_screlease(signal::hsa_signal_t, expected::hsa_signal_value_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_cas_screlease, Symbol("libhsa-runtime64")), hsa_signal_value_t, (hsa_signal_t, hsa_signal_value_t, hsa_signal_value_t), signal, expected, value)
end

function signal_cas_release(signal::hsa_signal_t, expected::hsa_signal_value_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_cas_release, Symbol("libhsa-runtime64")), hsa_signal_value_t, (hsa_signal_t, hsa_signal_value_t, hsa_signal_value_t), signal, expected, value)
end

function signal_add_scacq_screl(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_add_scacq_screl, Symbol("libhsa-runtime64")), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_add_acq_rel(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_add_acq_rel, Symbol("libhsa-runtime64")), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_add_scacquire(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_add_scacquire, Symbol("libhsa-runtime64")), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_add_acquire(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_add_acquire, Symbol("libhsa-runtime64")), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_add_relaxed(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_add_relaxed, Symbol("libhsa-runtime64")), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_add_screlease(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_add_screlease, Symbol("libhsa-runtime64")), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_add_release(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_add_release, Symbol("libhsa-runtime64")), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_subtract_scacq_screl(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_subtract_scacq_screl, Symbol("libhsa-runtime64")), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_subtract_acq_rel(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_subtract_acq_rel, Symbol("libhsa-runtime64")), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_subtract_scacquire(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_subtract_scacquire, Symbol("libhsa-runtime64")), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_subtract_acquire(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_subtract_acquire, Symbol("libhsa-runtime64")), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_subtract_relaxed(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_subtract_relaxed, Symbol("libhsa-runtime64")), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_subtract_screlease(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_subtract_screlease, Symbol("libhsa-runtime64")), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_subtract_release(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_subtract_release, Symbol("libhsa-runtime64")), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_and_scacq_screl(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_and_scacq_screl, Symbol("libhsa-runtime64")), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_and_acq_rel(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_and_acq_rel, Symbol("libhsa-runtime64")), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_and_scacquire(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_and_scacquire, Symbol("libhsa-runtime64")), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_and_acquire(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_and_acquire, Symbol("libhsa-runtime64")), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_and_relaxed(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_and_relaxed, Symbol("libhsa-runtime64")), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_and_screlease(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_and_screlease, Symbol("libhsa-runtime64")), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_and_release(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_and_release, Symbol("libhsa-runtime64")), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_or_scacq_screl(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_or_scacq_screl, Symbol("libhsa-runtime64")), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_or_acq_rel(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_or_acq_rel, Symbol("libhsa-runtime64")), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_or_scacquire(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_or_scacquire, Symbol("libhsa-runtime64")), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_or_acquire(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_or_acquire, Symbol("libhsa-runtime64")), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_or_relaxed(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_or_relaxed, Symbol("libhsa-runtime64")), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_or_screlease(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_or_screlease, Symbol("libhsa-runtime64")), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_or_release(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_or_release, Symbol("libhsa-runtime64")), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_xor_scacq_screl(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_xor_scacq_screl, Symbol("libhsa-runtime64")), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_xor_acq_rel(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_xor_acq_rel, Symbol("libhsa-runtime64")), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_xor_scacquire(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_xor_scacquire, Symbol("libhsa-runtime64")), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_xor_acquire(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_xor_acquire, Symbol("libhsa-runtime64")), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_xor_relaxed(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_xor_relaxed, Symbol("libhsa-runtime64")), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_xor_screlease(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_xor_screlease, Symbol("libhsa-runtime64")), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_xor_release(signal::hsa_signal_t, value::hsa_signal_value_t)
    ccall((:hsa_signal_xor_release, Symbol("libhsa-runtime64")), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function signal_wait_scacquire(signal::hsa_signal_t, condition::hsa_signal_condition_t, compare_value::hsa_signal_value_t, timeout_hint::UInt64, wait_state_hint::hsa_wait_state_t)
    ccall((:hsa_signal_wait_scacquire, Symbol("libhsa-runtime64")), hsa_signal_value_t, (hsa_signal_t, hsa_signal_condition_t, hsa_signal_value_t, UInt64, hsa_wait_state_t), signal, condition, compare_value, timeout_hint, wait_state_hint)
end

function signal_wait_relaxed(signal::hsa_signal_t, condition::hsa_signal_condition_t, compare_value::hsa_signal_value_t, timeout_hint::UInt64, wait_state_hint::hsa_wait_state_t)
    ccall((:hsa_signal_wait_relaxed, Symbol("libhsa-runtime64")), hsa_signal_value_t, (hsa_signal_t, hsa_signal_condition_t, hsa_signal_value_t, UInt64, hsa_wait_state_t), signal, condition, compare_value, timeout_hint, wait_state_hint)
end

function signal_wait_acquire(signal::hsa_signal_t, condition::hsa_signal_condition_t, compare_value::hsa_signal_value_t, timeout_hint::UInt64, wait_state_hint::hsa_wait_state_t)
    ccall((:hsa_signal_wait_acquire, Symbol("libhsa-runtime64")), hsa_signal_value_t, (hsa_signal_t, hsa_signal_condition_t, hsa_signal_value_t, UInt64, hsa_wait_state_t), signal, condition, compare_value, timeout_hint, wait_state_hint)
end

function signal_group_create(num_signals::UInt32, signals::Ref{hsa_signal_t}, num_consumers::UInt32, consumers::Ref{hsa_agent_t}, signal_group::Ref{hsa_signal_group_t})
    ccall((:hsa_signal_group_create, Symbol("libhsa-runtime64")), hsa_status_t, (UInt32, Ref{hsa_signal_t}, UInt32, Ref{hsa_agent_t}, Ref{hsa_signal_group_t}), num_signals, signals, num_consumers, consumers, signal_group)
end

function signal_group_destroy(signal_group::hsa_signal_group_t)
    ccall((:hsa_signal_group_destroy, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_signal_group_t,), signal_group)
end

function signal_group_wait_any_scacquire(signal_group::hsa_signal_group_t, conditions::Ref{hsa_signal_condition_t}, compare_values::Ref{hsa_signal_value_t}, wait_state_hint::hsa_wait_state_t, signal::Ref{hsa_signal_t}, value::Ref{hsa_signal_value_t})
    ccall((:hsa_signal_group_wait_any_scacquire, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_signal_group_t, Ref{hsa_signal_condition_t}, Ref{hsa_signal_value_t}, hsa_wait_state_t, Ref{hsa_signal_t}, Ref{hsa_signal_value_t}), signal_group, conditions, compare_values, wait_state_hint, signal, value)
end

function signal_group_wait_any_relaxed(signal_group::hsa_signal_group_t, conditions::Ref{hsa_signal_condition_t}, compare_values::Ref{hsa_signal_value_t}, wait_state_hint::hsa_wait_state_t, signal::Ref{hsa_signal_t}, value::Ref{hsa_signal_value_t})
    ccall((:hsa_signal_group_wait_any_relaxed, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_signal_group_t, Ref{hsa_signal_condition_t}, Ref{hsa_signal_value_t}, hsa_wait_state_t, Ref{hsa_signal_t}, Ref{hsa_signal_value_t}), signal_group, conditions, compare_values, wait_state_hint, signal, value)
end

function queue_create(agent::hsa_agent_t, size::UInt32, type::hsa_queue_type32_t, callback::Ref{Cvoid}, data::Ref{Cvoid}, private_segment_size::UInt32, group_segment_size::UInt32, queue::Ref{Ptr{hsa_queue_t}})
    ccall((:hsa_queue_create, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_agent_t, UInt32, hsa_queue_type32_t, Ref{Cvoid}, Ref{Cvoid}, UInt32, UInt32, Ref{Ptr{hsa_queue_t}}), agent, size, type, callback, data, private_segment_size, group_segment_size, queue)
end

function soft_queue_create(region::hsa_region_t, size::UInt32, type::hsa_queue_type32_t, features::UInt32, doorbell_signal::hsa_signal_t, queue::Ref{Ptr{hsa_queue_t}})
    ccall((:hsa_soft_queue_create, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_region_t, UInt32, hsa_queue_type32_t, UInt32, hsa_signal_t, Ref{Ptr{hsa_queue_t}}), region, size, type, features, doorbell_signal, queue)
end

function queue_destroy(queue::Ref{hsa_queue_t})
    ccall((:hsa_queue_destroy, Symbol("libhsa-runtime64")), hsa_status_t, (Ref{hsa_queue_t},), queue)
end

function queue_inactivate(queue::Ref{hsa_queue_t})
    ccall((:hsa_queue_inactivate, Symbol("libhsa-runtime64")), hsa_status_t, (Ref{hsa_queue_t},), queue)
end

function queue_load_read_index_acquire(queue::Ref{hsa_queue_t})
    ccall((:hsa_queue_load_read_index_acquire, Symbol("libhsa-runtime64")), UInt64, (Ref{hsa_queue_t},), queue)
end

function queue_load_read_index_scacquire(queue::Ref{hsa_queue_t})
    ccall((:hsa_queue_load_read_index_scacquire, Symbol("libhsa-runtime64")), UInt64, (Ref{hsa_queue_t},), queue)
end

function queue_load_read_index_relaxed(queue::Ref{hsa_queue_t})
    ccall((:hsa_queue_load_read_index_relaxed, Symbol("libhsa-runtime64")), UInt64, (Ref{hsa_queue_t},), queue)
end

function queue_load_write_index_acquire(queue::Ref{hsa_queue_t})
    ccall((:hsa_queue_load_write_index_acquire, Symbol("libhsa-runtime64")), UInt64, (Ref{hsa_queue_t},), queue)
end

function queue_load_write_index_scacquire(queue::Ref{hsa_queue_t})
    ccall((:hsa_queue_load_write_index_scacquire, Symbol("libhsa-runtime64")), UInt64, (Ref{hsa_queue_t},), queue)
end

function queue_load_write_index_relaxed(queue::Ref{hsa_queue_t})
    ccall((:hsa_queue_load_write_index_relaxed, Symbol("libhsa-runtime64")), UInt64, (Ref{hsa_queue_t},), queue)
end

function queue_store_write_index_relaxed(queue::Ref{hsa_queue_t}, value::UInt64)
    ccall((:hsa_queue_store_write_index_relaxed, Symbol("libhsa-runtime64")), Cvoid, (Ref{hsa_queue_t}, UInt64), queue, value)
end

function queue_store_write_index_release(queue::Ref{hsa_queue_t}, value::UInt64)
    ccall((:hsa_queue_store_write_index_release, Symbol("libhsa-runtime64")), Cvoid, (Ref{hsa_queue_t}, UInt64), queue, value)
end

function queue_store_write_index_screlease(queue::Ref{hsa_queue_t}, value::UInt64)
    ccall((:hsa_queue_store_write_index_screlease, Symbol("libhsa-runtime64")), Cvoid, (Ref{hsa_queue_t}, UInt64), queue, value)
end

function queue_cas_write_index_acq_rel(queue::Ref{hsa_queue_t}, expected::UInt64, value::UInt64)
    ccall((:hsa_queue_cas_write_index_acq_rel, Symbol("libhsa-runtime64")), UInt64, (Ref{hsa_queue_t}, UInt64, UInt64), queue, expected, value)
end

function queue_cas_write_index_scacq_screl(queue::Ref{hsa_queue_t}, expected::UInt64, value::UInt64)
    ccall((:hsa_queue_cas_write_index_scacq_screl, Symbol("libhsa-runtime64")), UInt64, (Ref{hsa_queue_t}, UInt64, UInt64), queue, expected, value)
end

function queue_cas_write_index_acquire(queue::Ref{hsa_queue_t}, expected::UInt64, value::UInt64)
    ccall((:hsa_queue_cas_write_index_acquire, Symbol("libhsa-runtime64")), UInt64, (Ref{hsa_queue_t}, UInt64, UInt64), queue, expected, value)
end

function queue_cas_write_index_scacquire(queue::Ref{hsa_queue_t}, expected::UInt64, value::UInt64)
    ccall((:hsa_queue_cas_write_index_scacquire, Symbol("libhsa-runtime64")), UInt64, (Ref{hsa_queue_t}, UInt64, UInt64), queue, expected, value)
end

function queue_cas_write_index_relaxed(queue::Ref{hsa_queue_t}, expected::UInt64, value::UInt64)
    ccall((:hsa_queue_cas_write_index_relaxed, Symbol("libhsa-runtime64")), UInt64, (Ref{hsa_queue_t}, UInt64, UInt64), queue, expected, value)
end

function queue_cas_write_index_release(queue::Ref{hsa_queue_t}, expected::UInt64, value::UInt64)
    ccall((:hsa_queue_cas_write_index_release, Symbol("libhsa-runtime64")), UInt64, (Ref{hsa_queue_t}, UInt64, UInt64), queue, expected, value)
end

function queue_cas_write_index_screlease(queue::Ref{hsa_queue_t}, expected::UInt64, value::UInt64)
    ccall((:hsa_queue_cas_write_index_screlease, Symbol("libhsa-runtime64")), UInt64, (Ref{hsa_queue_t}, UInt64, UInt64), queue, expected, value)
end

function queue_add_write_index_acq_rel(queue::Ref{hsa_queue_t}, value::UInt64)
    ccall((:hsa_queue_add_write_index_acq_rel, Symbol("libhsa-runtime64")), UInt64, (Ref{hsa_queue_t}, UInt64), queue, value)
end

function queue_add_write_index_scacq_screl(queue::Ref{hsa_queue_t}, value::UInt64)
    ccall((:hsa_queue_add_write_index_scacq_screl, Symbol("libhsa-runtime64")), UInt64, (Ref{hsa_queue_t}, UInt64), queue, value)
end

function queue_add_write_index_acquire(queue::Ref{hsa_queue_t}, value::UInt64)
    ccall((:hsa_queue_add_write_index_acquire, Symbol("libhsa-runtime64")), UInt64, (Ref{hsa_queue_t}, UInt64), queue, value)
end

function queue_add_write_index_scacquire(queue::Ref{hsa_queue_t}, value::UInt64)
    ccall((:hsa_queue_add_write_index_scacquire, Symbol("libhsa-runtime64")), UInt64, (Ref{hsa_queue_t}, UInt64), queue, value)
end

function queue_add_write_index_relaxed(queue::Ref{hsa_queue_t}, value::UInt64)
    ccall((:hsa_queue_add_write_index_relaxed, Symbol("libhsa-runtime64")), UInt64, (Ref{hsa_queue_t}, UInt64), queue, value)
end

function queue_add_write_index_release(queue::Ref{hsa_queue_t}, value::UInt64)
    ccall((:hsa_queue_add_write_index_release, Symbol("libhsa-runtime64")), UInt64, (Ref{hsa_queue_t}, UInt64), queue, value)
end

function queue_add_write_index_screlease(queue::Ref{hsa_queue_t}, value::UInt64)
    ccall((:hsa_queue_add_write_index_screlease, Symbol("libhsa-runtime64")), UInt64, (Ref{hsa_queue_t}, UInt64), queue, value)
end

function queue_store_read_index_relaxed(queue::Ref{hsa_queue_t}, value::UInt64)
    ccall((:hsa_queue_store_read_index_relaxed, Symbol("libhsa-runtime64")), Cvoid, (Ref{hsa_queue_t}, UInt64), queue, value)
end

function queue_store_read_index_release(queue::Ref{hsa_queue_t}, value::UInt64)
    ccall((:hsa_queue_store_read_index_release, Symbol("libhsa-runtime64")), Cvoid, (Ref{hsa_queue_t}, UInt64), queue, value)
end

function queue_store_read_index_screlease(queue::Ref{hsa_queue_t}, value::UInt64)
    ccall((:hsa_queue_store_read_index_screlease, Symbol("libhsa-runtime64")), Cvoid, (Ref{hsa_queue_t}, UInt64), queue, value)
end

function region_get_info(region::hsa_region_t, attribute::hsa_region_info_t, value::Ref{Cvoid})
    ccall((:hsa_region_get_info, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_region_t, hsa_region_info_t, Ref{Cvoid}), region, attribute, value)
end

function agent_iterate_regions(agent::hsa_agent_t, callback::Ref{Cvoid}, data::Ref{Cvoid})
    ccall((:hsa_agent_iterate_regions, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_agent_t, Ref{Cvoid}, Ref{Cvoid}), agent, callback, data)
end

function memory_allocate(region::hsa_region_t, size::Csize_t, ptr::Ref{Ptr{Cvoid}})
    ccall((:hsa_memory_allocate, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_region_t, Csize_t, Ref{Ptr{Cvoid}}), region, size, ptr)
end

function memory_free(ptr::Ref{Cvoid})
    ccall((:hsa_memory_free, Symbol("libhsa-runtime64")), hsa_status_t, (Ref{Cvoid},), ptr)
end

function memory_copy(dst::Ref{Cvoid}, src::Ref{Cvoid}, size::Csize_t)
    ccall((:hsa_memory_copy, Symbol("libhsa-runtime64")), hsa_status_t, (Ref{Cvoid}, Ref{Cvoid}, Csize_t), dst, src, size)
end

function memory_assign_agent(ptr::Ref{Cvoid}, agent::hsa_agent_t, access::hsa_access_permission_t)
    ccall((:hsa_memory_assign_agent, Symbol("libhsa-runtime64")), hsa_status_t, (Ref{Cvoid}, hsa_agent_t, hsa_access_permission_t), ptr, agent, access)
end

function memory_register(ptr::Ref{Cvoid}, size::Csize_t)
    ccall((:hsa_memory_register, Symbol("libhsa-runtime64")), hsa_status_t, (Ref{Cvoid}, Csize_t), ptr, size)
end

function memory_deregister(ptr::Ref{Cvoid}, size::Csize_t)
    ccall((:hsa_memory_deregister, Symbol("libhsa-runtime64")), hsa_status_t, (Ref{Cvoid}, Csize_t), ptr, size)
end

function isa_from_name(name, isa::Ref{hsa_isa_t})
    ccall((:hsa_isa_from_name, Symbol("libhsa-runtime64")), hsa_status_t, (Cstring, Ref{hsa_isa_t}), name, isa)
end

function agent_iterate_isas(agent::hsa_agent_t, callback::Ref{Cvoid}, data::Ref{Cvoid})
    ccall((:hsa_agent_iterate_isas, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_agent_t, Ref{Cvoid}, Ref{Cvoid}), agent, callback, data)
end

function isa_get_info(isa::hsa_isa_t, attribute::hsa_isa_info_t, index::UInt32, value::Ref{Cvoid})
    ccall((:hsa_isa_get_info, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_isa_t, hsa_isa_info_t, UInt32, Ref{Cvoid}), isa, attribute, index, value)
end

function isa_get_info_alt(isa::hsa_isa_t, attribute::hsa_isa_info_t, value::Ref{Cvoid})
    ccall((:hsa_isa_get_info_alt, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_isa_t, hsa_isa_info_t, Ref{Cvoid}), isa, attribute, value)
end

function isa_get_exception_policies(isa::hsa_isa_t, profile::hsa_profile_t, mask::Ref{UInt16})
    ccall((:hsa_isa_get_exception_policies, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_isa_t, hsa_profile_t, Ref{UInt16}), isa, profile, mask)
end

function isa_get_round_method(isa::hsa_isa_t, fp_type::hsa_fp_type_t, flush_mode::hsa_flush_mode_t, round_method::Ref{hsa_round_method_t})
    ccall((:hsa_isa_get_round_method, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_isa_t, hsa_fp_type_t, hsa_flush_mode_t, Ref{hsa_round_method_t}), isa, fp_type, flush_mode, round_method)
end

function wavefront_get_info(wavefront::hsa_wavefront_t, attribute::hsa_wavefront_info_t, value::Ref{Cvoid})
    ccall((:hsa_wavefront_get_info, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_wavefront_t, hsa_wavefront_info_t, Ref{Cvoid}), wavefront, attribute, value)
end

function isa_iterate_wavefronts(isa::hsa_isa_t, callback::Ref{Cvoid}, data::Ref{Cvoid})
    ccall((:hsa_isa_iterate_wavefronts, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_isa_t, Ref{Cvoid}, Ref{Cvoid}), isa, callback, data)
end

function isa_compatible(code_object_isa::hsa_isa_t, agent_isa::hsa_isa_t, result::Ref{Bool})
    ccall((:hsa_isa_compatible, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_isa_t, hsa_isa_t, Ref{Bool}), code_object_isa, agent_isa, result)
end

function code_object_reader_create_from_file(file::hsa_file_t, code_object_reader::Ref{hsa_code_object_reader_t})
    ccall((:hsa_code_object_reader_create_from_file, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_file_t, Ref{hsa_code_object_reader_t}), file, code_object_reader)
end

function code_object_reader_create_from_memory(code_object::Ref{Cvoid}, size::Csize_t, code_object_reader::Ref{hsa_code_object_reader_t})
    ccall((:hsa_code_object_reader_create_from_memory, Symbol("libhsa-runtime64")), hsa_status_t, (Ref{Cvoid}, Csize_t, Ref{hsa_code_object_reader_t}), code_object, size, code_object_reader)
end

function code_object_reader_destroy(code_object_reader::hsa_code_object_reader_t)
    ccall((:hsa_code_object_reader_destroy, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_code_object_reader_t,), code_object_reader)
end

function executable_create(profile::hsa_profile_t, executable_state::hsa_executable_state_t, options, executable::Ref{hsa_executable_t})
    ccall((:hsa_executable_create, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_profile_t, hsa_executable_state_t, Cstring, Ref{hsa_executable_t}), profile, executable_state, options, executable)
end

function executable_create_alt(profile::hsa_profile_t, default_float_rounding_mode::hsa_default_float_rounding_mode_t, options, executable::Ref{hsa_executable_t})
    ccall((:hsa_executable_create_alt, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_profile_t, hsa_default_float_rounding_mode_t, Cstring, Ref{hsa_executable_t}), profile, default_float_rounding_mode, options, executable)
end

function executable_destroy(executable::hsa_executable_t)
    ccall((:hsa_executable_destroy, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_executable_t,), executable)
end

function executable_load_program_code_object(executable::hsa_executable_t, code_object_reader::hsa_code_object_reader_t, options, loaded_code_object::Ref{hsa_loaded_code_object_t})
    ccall((:hsa_executable_load_program_code_object, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_executable_t, hsa_code_object_reader_t, Cstring, Ref{hsa_loaded_code_object_t}), executable, code_object_reader, options, loaded_code_object)
end

function executable_load_agent_code_object(executable::hsa_executable_t, agent::hsa_agent_t, code_object_reader::hsa_code_object_reader_t, options, loaded_code_object::Ref{hsa_loaded_code_object_t})
    ccall((:hsa_executable_load_agent_code_object, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_executable_t, hsa_agent_t, hsa_code_object_reader_t, Cstring, Ref{hsa_loaded_code_object_t}), executable, agent, code_object_reader, options, loaded_code_object)
end

function executable_freeze(executable::hsa_executable_t, options)
    ccall((:hsa_executable_freeze, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_executable_t, Cstring), executable, options)
end

function executable_get_info(executable::hsa_executable_t, attribute::hsa_executable_info_t, value::Ref{Cvoid})
    ccall((:hsa_executable_get_info, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_executable_t, hsa_executable_info_t, Ref{Cvoid}), executable, attribute, value)
end

function executable_global_variable_define(executable::hsa_executable_t, variable_name, address::Ref{Cvoid})
    ccall((:hsa_executable_global_variable_define, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_executable_t, Cstring, Ref{Cvoid}), executable, variable_name, address)
end

function executable_agent_global_variable_define(executable::hsa_executable_t, agent::hsa_agent_t, variable_name, address::Ref{Cvoid})
    ccall((:hsa_executable_agent_global_variable_define, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_executable_t, hsa_agent_t, Cstring, Ref{Cvoid}), executable, agent, variable_name, address)
end

function executable_readonly_variable_define(executable::hsa_executable_t, agent::hsa_agent_t, variable_name, address::Ref{Cvoid})
    ccall((:hsa_executable_readonly_variable_define, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_executable_t, hsa_agent_t, Cstring, Ref{Cvoid}), executable, agent, variable_name, address)
end

function executable_validate(executable::hsa_executable_t, result::Ref{UInt32})
    ccall((:hsa_executable_validate, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_executable_t, Ref{UInt32}), executable, result)
end

function executable_validate_alt(executable::hsa_executable_t, options, result::Ref{UInt32})
    ccall((:hsa_executable_validate_alt, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_executable_t, Cstring, Ref{UInt32}), executable, options, result)
end

function executable_get_symbol(executable::hsa_executable_t, module_name, symbol_name, agent::hsa_agent_t, call_convention::Int32, symbol::Ref{hsa_executable_symbol_t})
    ccall((:hsa_executable_get_symbol, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_executable_t, Cstring, Cstring, hsa_agent_t, Int32, Ref{hsa_executable_symbol_t}), executable, module_name, symbol_name, agent, call_convention, symbol)
end

function executable_get_symbol_by_name(executable::hsa_executable_t, symbol_name, agent::Ref{hsa_agent_t}, symbol::Ref{hsa_executable_symbol_t})
    ccall((:hsa_executable_get_symbol_by_name, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_executable_t, Cstring, Ref{hsa_agent_t}, Ref{hsa_executable_symbol_t}), executable, symbol_name, agent, symbol)
end

function executable_symbol_get_info(executable_symbol::hsa_executable_symbol_t, attribute::hsa_executable_symbol_info_t, value::Ref{Cvoid})
    ccall((:hsa_executable_symbol_get_info, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_executable_symbol_t, hsa_executable_symbol_info_t, Ref{Cvoid}), executable_symbol, attribute, value)
end

function executable_iterate_symbols(executable::hsa_executable_t, callback::Ref{Cvoid}, data::Ref{Cvoid})
    ccall((:hsa_executable_iterate_symbols, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_executable_t, Ref{Cvoid}, Ref{Cvoid}), executable, callback, data)
end

function executable_iterate_agent_symbols(executable::hsa_executable_t, agent::hsa_agent_t, callback::Ref{Cvoid}, data::Ref{Cvoid})
    ccall((:hsa_executable_iterate_agent_symbols, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_executable_t, hsa_agent_t, Ref{Cvoid}, Ref{Cvoid}), executable, agent, callback, data)
end

function executable_iterate_program_symbols(executable::hsa_executable_t, callback::Ref{Cvoid}, data::Ref{Cvoid})
    ccall((:hsa_executable_iterate_program_symbols, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_executable_t, Ref{Cvoid}, Ref{Cvoid}), executable, callback, data)
end

function code_object_serialize(code_object::hsa_code_object_t, alloc_callback::Ref{Cvoid}, callback_data::hsa_callback_data_t, options, serialized_code_object::Ref{Ptr{Cvoid}}, serialized_code_object_size::Ref{Csize_t})
    ccall((:hsa_code_object_serialize, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_code_object_t, Ref{Cvoid}, hsa_callback_data_t, Cstring, Ref{Ptr{Cvoid}}, Ref{Csize_t}), code_object, alloc_callback, callback_data, options, serialized_code_object, serialized_code_object_size)
end

function code_object_deserialize(serialized_code_object::Ref{Cvoid}, serialized_code_object_size::Csize_t, options, code_object::Ref{hsa_code_object_t})
    ccall((:hsa_code_object_deserialize, Symbol("libhsa-runtime64")), hsa_status_t, (Ref{Cvoid}, Csize_t, Cstring, Ref{hsa_code_object_t}), serialized_code_object, serialized_code_object_size, options, code_object)
end

function code_object_destroy(code_object::hsa_code_object_t)
    ccall((:hsa_code_object_destroy, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_code_object_t,), code_object)
end

function code_object_get_info(code_object::hsa_code_object_t, attribute::hsa_code_object_info_t, value::Ref{Cvoid})
    ccall((:hsa_code_object_get_info, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_code_object_t, hsa_code_object_info_t, Ref{Cvoid}), code_object, attribute, value)
end

function executable_load_code_object(executable::hsa_executable_t, agent::hsa_agent_t, code_object::hsa_code_object_t, options)
    ccall((:hsa_executable_load_code_object, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_executable_t, hsa_agent_t, hsa_code_object_t, Cstring), executable, agent, code_object, options)
end

function code_object_get_symbol(code_object::hsa_code_object_t, symbol_name, symbol::Ref{hsa_code_symbol_t})
    ccall((:hsa_code_object_get_symbol, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_code_object_t, Cstring, Ref{hsa_code_symbol_t}), code_object, symbol_name, symbol)
end

function code_object_get_symbol_from_name(code_object::hsa_code_object_t, module_name, symbol_name, symbol::Ref{hsa_code_symbol_t})
    ccall((:hsa_code_object_get_symbol_from_name, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_code_object_t, Cstring, Cstring, Ref{hsa_code_symbol_t}), code_object, module_name, symbol_name, symbol)
end

function code_symbol_get_info(code_symbol::hsa_code_symbol_t, attribute::hsa_code_symbol_info_t, value::Ref{Cvoid})
    ccall((:hsa_code_symbol_get_info, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_code_symbol_t, hsa_code_symbol_info_t, Ref{Cvoid}), code_symbol, attribute, value)
end

function code_object_iterate_symbols(code_object::hsa_code_object_t, callback::Ref{Cvoid}, data::Ref{Cvoid})
    ccall((:hsa_code_object_iterate_symbols, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_code_object_t, Ref{Cvoid}, Ref{Cvoid}), code_object, callback, data)
end

function py(__dest::Ref{Cvoid}, __src::Ref{Cvoid}, __n::Culong)
    ccall((:memcpy, Symbol("libhsa-runtime64")), Ptr{Cvoid}, (Ref{Cvoid}, Ref{Cvoid}, Culong), __dest, __src, __n)
end

function ove(__dest::Ref{Cvoid}, __src::Ref{Cvoid}, __n::Culong)
    ccall((:memmove, Symbol("libhsa-runtime64")), Ptr{Cvoid}, (Ref{Cvoid}, Ref{Cvoid}, Culong), __dest, __src, __n)
end

function cpy(__dest::Ref{Cvoid}, __src::Ref{Cvoid}, __c::Cint, __n::Csize_t)
    ccall((:memccpy, Symbol("libhsa-runtime64")), Ptr{Cvoid}, (Ref{Cvoid}, Ref{Cvoid}, Cint, Csize_t), __dest, __src, __c, __n)
end

function et(__s::Ref{Cvoid}, __c::Cint, __n::Culong)
    ccall((:memset, Symbol("libhsa-runtime64")), Ptr{Cvoid}, (Ref{Cvoid}, Cint, Culong), __s, __c, __n)
end

function mp(__s1::Ref{Cvoid}, __s2::Ref{Cvoid}, __n::Culong)
    ccall((:memcmp, Symbol("libhsa-runtime64")), Cint, (Ref{Cvoid}, Ref{Cvoid}, Culong), __s1, __s2, __n)
end

function hr(__s::Ref{Cvoid}, __c::Cint, __n::Culong)
    ccall((:memchr, Symbol("libhsa-runtime64")), Ptr{Cvoid}, (Ref{Cvoid}, Cint, Culong), __s, __c, __n)
end

function py(__dest, __src)
    ccall((:strcpy, Symbol("libhsa-runtime64")), Cstring, (Cstring, Cstring), __dest, __src)
end

function cpy(__dest, __src, __n::Culong)
    ccall((:strncpy, Symbol("libhsa-runtime64")), Cstring, (Cstring, Cstring, Culong), __dest, __src, __n)
end

function at(__dest, __src)
    ccall((:strcat, Symbol("libhsa-runtime64")), Cstring, (Cstring, Cstring), __dest, __src)
end

function cat(__dest, __src, __n::Culong)
    ccall((:strncat, Symbol("libhsa-runtime64")), Cstring, (Cstring, Cstring, Culong), __dest, __src, __n)
end

function mp(__s1, __s2)
    ccall((:strcmp, Symbol("libhsa-runtime64")), Cint, (Cstring, Cstring), __s1, __s2)
end

function cmp(__s1, __s2, __n::Culong)
    ccall((:strncmp, Symbol("libhsa-runtime64")), Cint, (Cstring, Cstring, Culong), __s1, __s2, __n)
end

function oll(__s1, __s2)
    ccall((:strcoll, Symbol("libhsa-runtime64")), Cint, (Cstring, Cstring), __s1, __s2)
end

function frm(__dest, __src, __n::Culong)
    ccall((:strxfrm, Symbol("libhsa-runtime64")), Culong, (Cstring, Cstring, Culong), __dest, __src, __n)
end

function oll_l(__s1, __s2, __l::locale_t)
    ccall((:strcoll_l, Symbol("libhsa-runtime64")), Cint, (Cstring, Cstring, locale_t), __s1, __s2, __l)
end

function frm_l(__dest, __src, __n::Csize_t, __l::locale_t)
    ccall((:strxfrm_l, Symbol("libhsa-runtime64")), Csize_t, (Cstring, Cstring, Csize_t, locale_t), __dest, __src, __n, __l)
end

function up(__s)
    ccall((:strdup, Symbol("libhsa-runtime64")), Cstring, (Cstring,), __s)
end

function dup(__string, __n::Culong)
    ccall((:strndup, Symbol("libhsa-runtime64")), Cstring, (Cstring, Culong), __string, __n)
end

function hr(__s, __c::Cint)
    ccall((:strchr, Symbol("libhsa-runtime64")), Cstring, (Cstring, Cint), __s, __c)
end

function chr(__s, __c::Cint)
    ccall((:strrchr, Symbol("libhsa-runtime64")), Cstring, (Cstring, Cint), __s, __c)
end

function spn(__s, __reject)
    ccall((:strcspn, Symbol("libhsa-runtime64")), Culong, (Cstring, Cstring), __s, __reject)
end

function pn(__s, __accept)
    ccall((:strspn, Symbol("libhsa-runtime64")), Culong, (Cstring, Cstring), __s, __accept)
end

function brk(__s, __accept)
    ccall((:strpbrk, Symbol("libhsa-runtime64")), Cstring, (Cstring, Cstring), __s, __accept)
end

function tr(__haystack, __needle)
    ccall((:strstr, Symbol("libhsa-runtime64")), Cstring, (Cstring, Cstring), __haystack, __needle)
end

function ok(__s, __delim)
    ccall((:strtok, Symbol("libhsa-runtime64")), Cstring, (Cstring, Cstring), __s, __delim)
end

function ok_r(__s, __delim, __save_ptr::Ref{Cstring})
    ccall((:strtok_r, Symbol("libhsa-runtime64")), Cstring, (Cstring, Cstring, Ref{Cstring}), __s, __delim, __save_ptr)
end

function en(__s)
    ccall((:strlen, Symbol("libhsa-runtime64")), Culong, (Cstring,), __s)
end

function len(__string, __maxlen::Csize_t)
    ccall((:strnlen, Symbol("libhsa-runtime64")), Csize_t, (Cstring, Csize_t), __string, __maxlen)
end

function rror(__errnum::Cint)
    ccall((:strerror, Symbol("libhsa-runtime64")), Cstring, (Cint,), __errnum)
end

function rror_r(__errnum::Cint, __buf, __buflen::Csize_t)
    ccall((:strerror_r, Symbol("libhsa-runtime64")), Cint, (Cint, Cstring, Csize_t), __errnum, __buf, __buflen)
end

function rror_l(__errnum::Cint, __l::locale_t)
    ccall((:strerror_l, Symbol("libhsa-runtime64")), Cstring, (Cint, locale_t), __errnum, __l)
end

function var""(__s1::Ref{Cvoid}, __s2::Ref{Cvoid}, __n::Csize_t)
    ccall((:bcmp, Symbol("libhsa-runtime64")), Cint, (Ref{Cvoid}, Ref{Cvoid}, Csize_t), __s1, __s2, __n)
end

function y(__src::Ref{Cvoid}, __dest::Ref{Cvoid}, __n::Csize_t)
    ccall((:bcopy, Symbol("libhsa-runtime64")), Cvoid, (Ref{Cvoid}, Ref{Cvoid}, Csize_t), __src, __dest, __n)
end

function o(__s::Ref{Cvoid}, __n::Culong)
    ccall((:bzero, Symbol("libhsa-runtime64")), Cvoid, (Ref{Cvoid}, Culong), __s, __n)
end

function x(__s, __c::Cint)
    ccall((:index, Symbol("libhsa-runtime64")), Cstring, (Cstring, Cint), __s, __c)
end

function ex(__s, __c::Cint)
    ccall((:rindex, Symbol("libhsa-runtime64")), Cstring, (Cstring, Cint), __s, __c)
end

function var""(__i::Cint)
    ccall((:ffs, Symbol("libhsa-runtime64")), Cint, (Cint,), __i)
end

function var""(__l::Clong)
    ccall((:ffsl, Symbol("libhsa-runtime64")), Cint, (Clong,), __l)
end

function l(__ll::Clonglong)
    ccall((:ffsll, Symbol("libhsa-runtime64")), Cint, (Clonglong,), __ll)
end

function asecmp(__s1, __s2)
    ccall((:strcasecmp, Symbol("libhsa-runtime64")), Cint, (Cstring, Cstring), __s1, __s2)
end

function casecmp(__s1, __s2, __n::Culong)
    ccall((:strncasecmp, Symbol("libhsa-runtime64")), Cint, (Cstring, Cstring, Culong), __s1, __s2, __n)
end

function asecmp_l(__s1, __s2, __loc::locale_t)
    ccall((:strcasecmp_l, Symbol("libhsa-runtime64")), Cint, (Cstring, Cstring, locale_t), __s1, __s2, __loc)
end

function casecmp_l(__s1, __s2, __n::Csize_t, __loc::locale_t)
    ccall((:strncasecmp_l, Symbol("libhsa-runtime64")), Cint, (Cstring, Cstring, Csize_t, locale_t), __s1, __s2, __n, __loc)
end

function icit_bzero(__s::Ref{Cvoid}, __n::Csize_t)
    ccall((:explicit_bzero, Symbol("libhsa-runtime64")), Cvoid, (Ref{Cvoid}, Csize_t), __s, __n)
end

function ep(__stringp::Ref{Cstring}, __delim)
    ccall((:strsep, Symbol("libhsa-runtime64")), Cstring, (Ref{Cstring}, Cstring), __stringp, __delim)
end

function ignal(__sig::Cint)
    ccall((:strsignal, Symbol("libhsa-runtime64")), Cstring, (Cint,), __sig)
end

function py(__dest, __src)
    ccall((:stpcpy, Symbol("libhsa-runtime64")), Cstring, (Cstring, Cstring), __dest, __src)
end

function cpy(__dest, __src, __n::Culong)
    ccall((:stpncpy, Symbol("libhsa-runtime64")), Cstring, (Cstring, Cstring, Culong), __dest, __src, __n)
end

function var""(a::UInt32, b::UInt32)
    ccall((:Min, Symbol("libhsa-runtime64")), UInt32, (UInt32, UInt32), a, b)
end

function amd_queue_intercept_register(queue::Ref{hsa_queue_t}, callback::hsa_amd_queue_intercept_handler, user_data::Ref{Cvoid})
    ccall((:hsa_amd_queue_intercept_register, Symbol("libhsa-runtime64")), hsa_status_t, (Ref{hsa_queue_t}, hsa_amd_queue_intercept_handler, Ref{Cvoid}), queue, callback, user_data)
end

function amd_queue_intercept_create(agent_handle::hsa_agent_t, size::UInt32, type::hsa_queue_type32_t, callback::Ref{Cvoid}, data::Ref{Cvoid}, private_segment_size::UInt32, group_segment_size::UInt32, queue::Ref{Ptr{hsa_queue_t}})
    ccall((:hsa_amd_queue_intercept_create, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_agent_t, UInt32, hsa_queue_type32_t, Ref{Cvoid}, Ref{Cvoid}, UInt32, UInt32, Ref{Ptr{hsa_queue_t}}), agent_handle, size, type, callback, data, private_segment_size, group_segment_size, queue)
end

function amd_runtime_queue_create_register(callback::hsa_amd_runtime_queue_notifier, user_data::Ref{Cvoid})
    ccall((:hsa_amd_runtime_queue_create_register, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_amd_runtime_queue_notifier, Ref{Cvoid}), callback, user_data)
end

function Api(src::Ref{Cvoid}, dest::Ref{Cvoid}, size::Csize_t)
    ccall((:copyApi, Symbol("libhsa-runtime64")), Cvoid, (Ref{Cvoid}, Ref{Cvoid}, Csize_t), src, dest, size)
end

function Element(dest::Ref{ApiTableVersion}, src::Ref{ApiTableVersion})
    ccall((:copyElement, Symbol("libhsa-runtime64")), Cvoid, (Ref{ApiTableVersion}, Ref{ApiTableVersion}), dest, src)
end

function Tables(src::Ref{HsaApiTable}, dest::Ref{HsaApiTable})
    ccall((:copyTables, Symbol("libhsa-runtime64")), Cvoid, (Ref{HsaApiTable}, Ref{HsaApiTable}), src, dest)
end

function ext_image_get_capability(agent::hsa_agent_t, geometry::hsa_ext_image_geometry_t, image_format::Ref{hsa_ext_image_format_t}, capability_mask::Ref{UInt32})
    ccall((:hsa_ext_image_get_capability, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_agent_t, hsa_ext_image_geometry_t, Ref{hsa_ext_image_format_t}, Ref{UInt32}), agent, geometry, image_format, capability_mask)
end

function ext_image_get_capability_with_layout(agent::hsa_agent_t, geometry::hsa_ext_image_geometry_t, image_format::Ref{hsa_ext_image_format_t}, image_data_layout::hsa_ext_image_data_layout_t, capability_mask::Ref{UInt32})
    ccall((:hsa_ext_image_get_capability_with_layout, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_agent_t, hsa_ext_image_geometry_t, Ref{hsa_ext_image_format_t}, hsa_ext_image_data_layout_t, Ref{UInt32}), agent, geometry, image_format, image_data_layout, capability_mask)
end

function ext_image_data_get_info(agent::hsa_agent_t, image_descriptor::Ref{hsa_ext_image_descriptor_t}, access_permission::hsa_access_permission_t, image_data_info::Ref{hsa_ext_image_data_info_t})
    ccall((:hsa_ext_image_data_get_info, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_agent_t, Ref{hsa_ext_image_descriptor_t}, hsa_access_permission_t, Ref{hsa_ext_image_data_info_t}), agent, image_descriptor, access_permission, image_data_info)
end

function ext_image_data_get_info_with_layout(agent::hsa_agent_t, image_descriptor::Ref{hsa_ext_image_descriptor_t}, access_permission::hsa_access_permission_t, image_data_layout::hsa_ext_image_data_layout_t, image_data_row_pitch::Csize_t, image_data_slice_pitch::Csize_t, image_data_info::Ref{hsa_ext_image_data_info_t})
    ccall((:hsa_ext_image_data_get_info_with_layout, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_agent_t, Ref{hsa_ext_image_descriptor_t}, hsa_access_permission_t, hsa_ext_image_data_layout_t, Csize_t, Csize_t, Ref{hsa_ext_image_data_info_t}), agent, image_descriptor, access_permission, image_data_layout, image_data_row_pitch, image_data_slice_pitch, image_data_info)
end

function ext_image_create(agent::hsa_agent_t, image_descriptor::Ref{hsa_ext_image_descriptor_t}, image_data::Ref{Cvoid}, access_permission::hsa_access_permission_t, image::Ref{hsa_ext_image_t})
    ccall((:hsa_ext_image_create, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_agent_t, Ref{hsa_ext_image_descriptor_t}, Ref{Cvoid}, hsa_access_permission_t, Ref{hsa_ext_image_t}), agent, image_descriptor, image_data, access_permission, image)
end

function ext_image_create_with_layout(agent::hsa_agent_t, image_descriptor::Ref{hsa_ext_image_descriptor_t}, image_data::Ref{Cvoid}, access_permission::hsa_access_permission_t, image_data_layout::hsa_ext_image_data_layout_t, image_data_row_pitch::Csize_t, image_data_slice_pitch::Csize_t, image::Ref{hsa_ext_image_t})
    ccall((:hsa_ext_image_create_with_layout, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_agent_t, Ref{hsa_ext_image_descriptor_t}, Ref{Cvoid}, hsa_access_permission_t, hsa_ext_image_data_layout_t, Csize_t, Csize_t, Ref{hsa_ext_image_t}), agent, image_descriptor, image_data, access_permission, image_data_layout, image_data_row_pitch, image_data_slice_pitch, image)
end

function ext_image_destroy(agent::hsa_agent_t, image::hsa_ext_image_t)
    ccall((:hsa_ext_image_destroy, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_agent_t, hsa_ext_image_t), agent, image)
end

function ext_image_copy(agent::hsa_agent_t, src_image::hsa_ext_image_t, src_offset::Ref{hsa_dim3_t}, dst_image::hsa_ext_image_t, dst_offset::Ref{hsa_dim3_t}, range::Ref{hsa_dim3_t})
    ccall((:hsa_ext_image_copy, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_agent_t, hsa_ext_image_t, Ref{hsa_dim3_t}, hsa_ext_image_t, Ref{hsa_dim3_t}, Ref{hsa_dim3_t}), agent, src_image, src_offset, dst_image, dst_offset, range)
end

function ext_image_import(agent::hsa_agent_t, src_memory::Ref{Cvoid}, src_row_pitch::Csize_t, src_slice_pitch::Csize_t, dst_image::hsa_ext_image_t, image_region::Ref{hsa_ext_image_region_t})
    ccall((:hsa_ext_image_import, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_agent_t, Ref{Cvoid}, Csize_t, Csize_t, hsa_ext_image_t, Ref{hsa_ext_image_region_t}), agent, src_memory, src_row_pitch, src_slice_pitch, dst_image, image_region)
end

function ext_image_export(agent::hsa_agent_t, src_image::hsa_ext_image_t, dst_memory::Ref{Cvoid}, dst_row_pitch::Csize_t, dst_slice_pitch::Csize_t, image_region::Ref{hsa_ext_image_region_t})
    ccall((:hsa_ext_image_export, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_agent_t, hsa_ext_image_t, Ref{Cvoid}, Csize_t, Csize_t, Ref{hsa_ext_image_region_t}), agent, src_image, dst_memory, dst_row_pitch, dst_slice_pitch, image_region)
end

function ext_image_clear(agent::hsa_agent_t, image::hsa_ext_image_t, data::Ref{Cvoid}, image_region::Ref{hsa_ext_image_region_t})
    ccall((:hsa_ext_image_clear, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_agent_t, hsa_ext_image_t, Ref{Cvoid}, Ref{hsa_ext_image_region_t}), agent, image, data, image_region)
end

function ext_sampler_create(agent::hsa_agent_t, sampler_descriptor::Ref{hsa_ext_sampler_descriptor_t}, sampler::Ref{hsa_ext_sampler_t})
    ccall((:hsa_ext_sampler_create, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_agent_t, Ref{hsa_ext_sampler_descriptor_t}, Ref{hsa_ext_sampler_t}), agent, sampler_descriptor, sampler)
end

function ext_sampler_destroy(agent::hsa_agent_t, sampler::hsa_ext_sampler_t)
    ccall((:hsa_ext_sampler_destroy, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_agent_t, hsa_ext_sampler_t), agent, sampler)
end

function amd_coherency_get_type(agent::hsa_agent_t, type::Ref{hsa_amd_coherency_type_t})
    ccall((:hsa_amd_coherency_get_type, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_agent_t, Ref{hsa_amd_coherency_type_t}), agent, type)
end

function amd_coherency_set_type(agent::hsa_agent_t, type::hsa_amd_coherency_type_t)
    ccall((:hsa_amd_coherency_set_type, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_agent_t, hsa_amd_coherency_type_t), agent, type)
end

function amd_profiling_set_profiler_enabled(queue::Ref{hsa_queue_t}, enable::Cint)
    ccall((:hsa_amd_profiling_set_profiler_enabled, Symbol("libhsa-runtime64")), hsa_status_t, (Ref{hsa_queue_t}, Cint), queue, enable)
end

function amd_profiling_async_copy_enable(enable::Bool)
    ccall((:hsa_amd_profiling_async_copy_enable, Symbol("libhsa-runtime64")), hsa_status_t, (Bool,), enable)
end

function amd_profiling_get_dispatch_time(agent::hsa_agent_t, signal::hsa_signal_t, time::Ref{hsa_amd_profiling_dispatch_time_t})
    ccall((:hsa_amd_profiling_get_dispatch_time, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_agent_t, hsa_signal_t, Ref{hsa_amd_profiling_dispatch_time_t}), agent, signal, time)
end

function amd_profiling_get_async_copy_time(signal::hsa_signal_t, time::Ref{hsa_amd_profiling_async_copy_time_t})
    ccall((:hsa_amd_profiling_get_async_copy_time, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_signal_t, Ref{hsa_amd_profiling_async_copy_time_t}), signal, time)
end

function amd_profiling_convert_tick_to_system_domain(agent::hsa_agent_t, agent_tick::UInt64, system_tick::Ref{UInt64})
    ccall((:hsa_amd_profiling_convert_tick_to_system_domain, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_agent_t, UInt64, Ref{UInt64}), agent, agent_tick, system_tick)
end

function amd_signal_create(initial_value::hsa_signal_value_t, num_consumers::UInt32, consumers::Ref{hsa_agent_t}, attributes::UInt64, signal::Ref{hsa_signal_t})
    ccall((:hsa_amd_signal_create, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_signal_value_t, UInt32, Ref{hsa_agent_t}, UInt64, Ref{hsa_signal_t}), initial_value, num_consumers, consumers, attributes, signal)
end

function amd_signal_async_handler(signal::hsa_signal_t, cond::hsa_signal_condition_t, value::hsa_signal_value_t, handler::hsa_amd_signal_handler, arg::Ref{Cvoid})
    ccall((:hsa_amd_signal_async_handler, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_signal_t, hsa_signal_condition_t, hsa_signal_value_t, hsa_amd_signal_handler, Ref{Cvoid}), signal, cond, value, handler, arg)
end

function amd_async_function(callback::Ref{Cvoid}, arg::Ref{Cvoid})
    ccall((:hsa_amd_async_function, Symbol("libhsa-runtime64")), hsa_status_t, (Ref{Cvoid}, Ref{Cvoid}), callback, arg)
end

function amd_signal_wait_any(signal_count::UInt32, signals::Ref{hsa_signal_t}, conds::Ref{hsa_signal_condition_t}, values::Ref{hsa_signal_value_t}, timeout_hint::UInt64, wait_hint::hsa_wait_state_t, satisfying_value::Ref{hsa_signal_value_t})
    ccall((:hsa_amd_signal_wait_any, Symbol("libhsa-runtime64")), UInt32, (UInt32, Ref{hsa_signal_t}, Ref{hsa_signal_condition_t}, Ref{hsa_signal_value_t}, UInt64, hsa_wait_state_t, Ref{hsa_signal_value_t}), signal_count, signals, conds, values, timeout_hint, wait_hint, satisfying_value)
end

function amd_image_get_info_max_dim(agent::hsa_agent_t, attribute::hsa_agent_info_t, value::Ref{Cvoid})
    ccall((:hsa_amd_image_get_info_max_dim, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_agent_t, hsa_agent_info_t, Ref{Cvoid}), agent, attribute, value)
end

function amd_queue_cu_set_mask(queue::Ref{hsa_queue_t}, num_cu_mask_count::UInt32, cu_mask::Ref{UInt32})
    ccall((:hsa_amd_queue_cu_set_mask, Symbol("libhsa-runtime64")), hsa_status_t, (Ref{hsa_queue_t}, UInt32, Ref{UInt32}), queue, num_cu_mask_count, cu_mask)
end

function amd_memory_pool_get_info(memory_pool::hsa_amd_memory_pool_t, attribute::hsa_amd_memory_pool_info_t, value::Ref{Cvoid})
    ccall((:hsa_amd_memory_pool_get_info, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_amd_memory_pool_t, hsa_amd_memory_pool_info_t, Ref{Cvoid}), memory_pool, attribute, value)
end

function amd_agent_iterate_memory_pools(agent::hsa_agent_t, callback::Ref{Cvoid}, data::Ref{Cvoid})
    ccall((:hsa_amd_agent_iterate_memory_pools, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_agent_t, Ref{Cvoid}, Ref{Cvoid}), agent, callback, data)
end

function amd_memory_pool_allocate(memory_pool::hsa_amd_memory_pool_t, size::Csize_t, flags::UInt32, ptr::Ref{Ptr{Cvoid}})
    ccall((:hsa_amd_memory_pool_allocate, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_amd_memory_pool_t, Csize_t, UInt32, Ref{Ptr{Cvoid}}), memory_pool, size, flags, ptr)
end

function amd_memory_pool_free(ptr::Ref{Cvoid})
    ccall((:hsa_amd_memory_pool_free, Symbol("libhsa-runtime64")), hsa_status_t, (Ref{Cvoid},), ptr)
end

function amd_memory_async_copy(dst::Ref{Cvoid}, dst_agent::hsa_agent_t, src::Ref{Cvoid}, src_agent::hsa_agent_t, size::Csize_t, num_dep_signals::UInt32, dep_signals::Ref{hsa_signal_t}, completion_signal::hsa_signal_t)
    ccall((:hsa_amd_memory_async_copy, Symbol("libhsa-runtime64")), hsa_status_t, (Ref{Cvoid}, hsa_agent_t, Ref{Cvoid}, hsa_agent_t, Csize_t, UInt32, Ref{hsa_signal_t}, hsa_signal_t), dst, dst_agent, src, src_agent, size, num_dep_signals, dep_signals, completion_signal)
end

function amd_memory_async_copy_rect(dst::Ref{hsa_pitched_ptr_t}, dst_offset::Ref{hsa_dim3_t}, src::Ref{hsa_pitched_ptr_t}, src_offset::Ref{hsa_dim3_t}, range::Ref{hsa_dim3_t}, copy_agent::hsa_agent_t, dir::hsa_amd_copy_direction_t, num_dep_signals::UInt32, dep_signals::Ref{hsa_signal_t}, completion_signal::hsa_signal_t)
    ccall((:hsa_amd_memory_async_copy_rect, Symbol("libhsa-runtime64")), hsa_status_t, (Ref{hsa_pitched_ptr_t}, Ref{hsa_dim3_t}, Ref{hsa_pitched_ptr_t}, Ref{hsa_dim3_t}, Ref{hsa_dim3_t}, hsa_agent_t, hsa_amd_copy_direction_t, UInt32, Ref{hsa_signal_t}, hsa_signal_t), dst, dst_offset, src, src_offset, range, copy_agent, dir, num_dep_signals, dep_signals, completion_signal)
end

function amd_agent_memory_pool_get_info(agent::hsa_agent_t, memory_pool::hsa_amd_memory_pool_t, attribute::hsa_amd_agent_memory_pool_info_t, value::Ref{Cvoid})
    ccall((:hsa_amd_agent_memory_pool_get_info, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_agent_t, hsa_amd_memory_pool_t, hsa_amd_agent_memory_pool_info_t, Ref{Cvoid}), agent, memory_pool, attribute, value)
end

function amd_agents_allow_access(num_agents::UInt32, agents::Ref{hsa_agent_t}, flags::Ref{UInt32}, ptr::Ref{Cvoid})
    ccall((:hsa_amd_agents_allow_access, Symbol("libhsa-runtime64")), hsa_status_t, (UInt32, Ref{hsa_agent_t}, Ref{UInt32}, Ref{Cvoid}), num_agents, agents, flags, ptr)
end

function amd_memory_pool_can_migrate(src_memory_pool::hsa_amd_memory_pool_t, dst_memory_pool::hsa_amd_memory_pool_t, result::Ref{Bool})
    ccall((:hsa_amd_memory_pool_can_migrate, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_amd_memory_pool_t, hsa_amd_memory_pool_t, Ref{Bool}), src_memory_pool, dst_memory_pool, result)
end

function amd_memory_migrate(ptr::Ref{Cvoid}, memory_pool::hsa_amd_memory_pool_t, flags::UInt32)
    ccall((:hsa_amd_memory_migrate, Symbol("libhsa-runtime64")), hsa_status_t, (Ref{Cvoid}, hsa_amd_memory_pool_t, UInt32), ptr, memory_pool, flags)
end

function amd_memory_lock(host_ptr::Ref{Cvoid}, size::Csize_t, agents::Ref{hsa_agent_t}, num_agent::Cint, agent_ptr::Ref{Ptr{Cvoid}})
    ccall((:hsa_amd_memory_lock, Symbol("libhsa-runtime64")), hsa_status_t, (Ref{Cvoid}, Csize_t, Ref{hsa_agent_t}, Cint, Ref{Ptr{Cvoid}}), host_ptr, size, agents, num_agent, agent_ptr)
end

function amd_memory_lock_to_pool(host_ptr::Ref{Cvoid}, size::Csize_t, agents::Ref{hsa_agent_t}, num_agent::Cint, pool::hsa_amd_memory_pool_t, flags::UInt32, agent_ptr::Ref{Ptr{Cvoid}})
    ccall((:hsa_amd_memory_lock_to_pool, Symbol("libhsa-runtime64")), hsa_status_t, (Ref{Cvoid}, Csize_t, Ref{hsa_agent_t}, Cint, hsa_amd_memory_pool_t, UInt32, Ref{Ptr{Cvoid}}), host_ptr, size, agents, num_agent, pool, flags, agent_ptr)
end

function amd_memory_unlock(host_ptr::Ref{Cvoid})
    ccall((:hsa_amd_memory_unlock, Symbol("libhsa-runtime64")), hsa_status_t, (Ref{Cvoid},), host_ptr)
end

function amd_memory_fill(ptr::Ref{Cvoid}, value::UInt32, count::Csize_t)
    ccall((:hsa_amd_memory_fill, Symbol("libhsa-runtime64")), hsa_status_t, (Ref{Cvoid}, UInt32, Csize_t), ptr, value, count)
end

function amd_interop_map_buffer(num_agents::UInt32, agents::Ref{hsa_agent_t}, interop_handle::Cint, flags::UInt32, size::Ref{Csize_t}, ptr::Ref{Ptr{Cvoid}}, metadata_size::Ref{Csize_t}, metadata::Ref{Ptr{Cvoid}})
    ccall((:hsa_amd_interop_map_buffer, Symbol("libhsa-runtime64")), hsa_status_t, (UInt32, Ref{hsa_agent_t}, Cint, UInt32, Ref{Csize_t}, Ref{Ptr{Cvoid}}, Ref{Csize_t}, Ref{Ptr{Cvoid}}), num_agents, agents, interop_handle, flags, size, ptr, metadata_size, metadata)
end

function amd_interop_unmap_buffer(ptr::Ref{Cvoid})
    ccall((:hsa_amd_interop_unmap_buffer, Symbol("libhsa-runtime64")), hsa_status_t, (Ref{Cvoid},), ptr)
end

function amd_image_create(agent::hsa_agent_t, image_descriptor::Ref{hsa_ext_image_descriptor_t}, image_layout::Ref{hsa_amd_image_descriptor_t}, image_data::Ref{Cvoid}, access_permission::hsa_access_permission_t, image::Ref{hsa_ext_image_t})
    ccall((:hsa_amd_image_create, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_agent_t, Ref{hsa_ext_image_descriptor_t}, Ref{hsa_amd_image_descriptor_t}, Ref{Cvoid}, hsa_access_permission_t, Ref{hsa_ext_image_t}), agent, image_descriptor, image_layout, image_data, access_permission, image)
end

function amd_pointer_info(ptr::Ref{Cvoid}, info::Ref{hsa_amd_pointer_info_t}, alloc::Ref{Cvoid}, num_agents_accessible::Ref{UInt32}, accessible::Ref{Ptr{hsa_agent_t}})
    ccall((:hsa_amd_pointer_info, Symbol("libhsa-runtime64")), hsa_status_t, (Ref{Cvoid}, Ref{hsa_amd_pointer_info_t}, Ref{Cvoid}, Ref{UInt32}, Ref{Ptr{hsa_agent_t}}), ptr, info, alloc, num_agents_accessible, accessible)
end

function amd_pointer_info_set_userdata(ptr::Ref{Cvoid}, userdata::Ref{Cvoid})
    ccall((:hsa_amd_pointer_info_set_userdata, Symbol("libhsa-runtime64")), hsa_status_t, (Ref{Cvoid}, Ref{Cvoid}), ptr, userdata)
end

function amd_ipc_memory_create(ptr::Ref{Cvoid}, len::Csize_t, handle::Ref{hsa_amd_ipc_memory_t})
    ccall((:hsa_amd_ipc_memory_create, Symbol("libhsa-runtime64")), hsa_status_t, (Ref{Cvoid}, Csize_t, Ref{hsa_amd_ipc_memory_t}), ptr, len, handle)
end

function amd_ipc_memory_attach(handle::Ref{hsa_amd_ipc_memory_t}, len::Csize_t, num_agents::UInt32, mapping_agents::Ref{hsa_agent_t}, mapped_ptr::Ref{Ptr{Cvoid}})
    ccall((:hsa_amd_ipc_memory_attach, Symbol("libhsa-runtime64")), hsa_status_t, (Ref{hsa_amd_ipc_memory_t}, Csize_t, UInt32, Ref{hsa_agent_t}, Ref{Ptr{Cvoid}}), handle, len, num_agents, mapping_agents, mapped_ptr)
end

function amd_ipc_memory_detach(mapped_ptr::Ref{Cvoid})
    ccall((:hsa_amd_ipc_memory_detach, Symbol("libhsa-runtime64")), hsa_status_t, (Ref{Cvoid},), mapped_ptr)
end

function amd_ipc_signal_create(signal::hsa_signal_t, handle::Ref{hsa_amd_ipc_signal_t})
    ccall((:hsa_amd_ipc_signal_create, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_signal_t, Ref{hsa_amd_ipc_signal_t}), signal, handle)
end

function amd_ipc_signal_attach(handle::Ref{hsa_amd_ipc_signal_t}, signal::Ref{hsa_signal_t})
    ccall((:hsa_amd_ipc_signal_attach, Symbol("libhsa-runtime64")), hsa_status_t, (Ref{hsa_amd_ipc_signal_t}, Ref{hsa_signal_t}), handle, signal)
end

function amd_register_system_event_handler(callback::hsa_amd_system_event_callback_t, data::Ref{Cvoid})
    ccall((:hsa_amd_register_system_event_handler, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_amd_system_event_callback_t, Ref{Cvoid}), callback, data)
end

function amd_queue_set_priority(queue::Ref{hsa_queue_t}, priority::hsa_amd_queue_priority_t)
    ccall((:hsa_amd_queue_set_priority, Symbol("libhsa-runtime64")), hsa_status_t, (Ref{hsa_queue_t}, hsa_amd_queue_priority_t), queue, priority)
end

function amd_register_deallocation_callback(ptr::Ref{Cvoid}, callback::hsa_amd_deallocation_callback_t, user_data::Ref{Cvoid})
    ccall((:hsa_amd_register_deallocation_callback, Symbol("libhsa-runtime64")), hsa_status_t, (Ref{Cvoid}, hsa_amd_deallocation_callback_t, Ref{Cvoid}), ptr, callback, user_data)
end

function amd_deregister_deallocation_callback(ptr::Ref{Cvoid}, callback::hsa_amd_deallocation_callback_t)
    ccall((:hsa_amd_deregister_deallocation_callback, Symbol("libhsa-runtime64")), hsa_status_t, (Ref{Cvoid}, hsa_amd_deallocation_callback_t), ptr, callback)
end

function ext_tools_set_correlation_handler(agent::hsa_agent_t, correlation_handle::Ref{Cvoid})
    ccall((:hsa_ext_tools_set_correlation_handler, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_agent_t, Ref{Cvoid}), agent, correlation_handle)
end

function ext_tools_wave_control(agent::hsa_agent_t, action::hsa_ext_tools_wave_action_t, mode::hsa_ext_tools_wave_mode_t, trap_id::UInt32, msg_ptr::Ref{Cvoid})
    ccall((:hsa_ext_tools_wave_control, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_agent_t, hsa_ext_tools_wave_action_t, hsa_ext_tools_wave_mode_t, UInt32, Ref{Cvoid}), agent, action, mode, trap_id, msg_ptr)
end

function ext_tools_flush_cache(agent::hsa_agent_t, options::hsa_ext_tools_cache_flush_options_t)
    ccall((:hsa_ext_tools_flush_cache, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_agent_t, hsa_ext_tools_cache_flush_options_t), agent, options)
end

function ext_tools_install_trap(agent::hsa_agent_t, type::hsa_ext_tools_trap_type_t, trap_handler::Ref{Cvoid}, trap_buffer::Ref{Cvoid}, trap_handler_size::Csize_t, trap_buffer_size::Csize_t)
    ccall((:hsa_ext_tools_install_trap, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_agent_t, hsa_ext_tools_trap_type_t, Ref{Cvoid}, Ref{Cvoid}, Csize_t, Csize_t), agent, type, trap_handler, trap_buffer, trap_handler_size, trap_buffer_size)
end

function ext_tools_set_exception_policy(agent::hsa_agent_t, exception_policy::hsa_ext_tools_exception_policy_t)
    ccall((:hsa_ext_tools_set_exception_policy, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_agent_t, hsa_ext_tools_exception_policy_t), agent, exception_policy)
end

function ext_tools_get_exception_policy(agent::hsa_agent_t, exception_policy::Ref{hsa_ext_tools_exception_policy_t})
    ccall((:hsa_ext_tools_get_exception_policy, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_agent_t, Ref{hsa_ext_tools_exception_policy_t}), agent, exception_policy)
end

function ext_tools_set_kernel_execution_mode(agent::hsa_agent_t, mode::hsa_ext_tools_kernel_execution_mode_t)
    ccall((:hsa_ext_tools_set_kernel_execution_mode, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_agent_t, hsa_ext_tools_kernel_execution_mode_t), agent, mode)
end

function ext_tools_get_kernel_execution_mode(agent::hsa_agent_t, mode::Ref{hsa_ext_tools_kernel_execution_mode_t})
    ccall((:hsa_ext_tools_get_kernel_execution_mode, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_agent_t, Ref{hsa_ext_tools_kernel_execution_mode_t}), agent, mode)
end

function ext_tools_register(agent::hsa_agent_t)
    ccall((:hsa_ext_tools_register, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_agent_t,), agent)
end

function ext_tools_unregister(agent::hsa_agent_t)
    ccall((:hsa_ext_tools_unregister, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_agent_t,), agent)
end

function ext_tools_address_watch(agent::hsa_agent_t, num_watch_points::UInt32, mode::Ref{hsa_ext_tools_address_watch_mode_t}, watch_address::Ref{Ptr{Cvoid}}, watch_mask::Ref{UInt64}, watch_event::Ref{hsa_ext_tools_event_t})
    ccall((:hsa_ext_tools_address_watch, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_agent_t, UInt32, Ref{hsa_ext_tools_address_watch_mode_t}, Ref{Ptr{Cvoid}}, Ref{UInt64}, Ref{hsa_ext_tools_event_t}), agent, num_watch_points, mode, watch_address, watch_mask, watch_event)
end

function ext_tools_get_dispatch_debug_info(agent::hsa_agent_t, info::Ref{hsa_ext_tools_dispatch_debug_info_t})
    ccall((:hsa_ext_tools_get_dispatch_debug_info, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_agent_t, Ref{hsa_ext_tools_dispatch_debug_info_t}), agent, info)
end

function ext_tools_dmacopy(agent::hsa_agent_t, src_addr::Ref{UInt32}, dst_addr::Ref{UInt32}, size::UInt32)
    ccall((:hsa_ext_tools_dmacopy, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_agent_t, Ref{UInt32}, Ref{UInt32}, UInt32), agent, src_addr, dst_addr, size)
end

function ext_tools_create_event(agent::hsa_agent_t, auto_reset::Bool, event::Ref{hsa_ext_tools_event_t}, event_id::Ref{UInt32})
    ccall((:hsa_ext_tools_create_event, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_agent_t, Bool, Ref{hsa_ext_tools_event_t}, Ref{UInt32}), agent, auto_reset, event, event_id)
end

function ext_tools_wait_event(timeout::Int32, event::hsa_ext_tools_event_t)
    ccall((:hsa_ext_tools_wait_event, Symbol("libhsa-runtime64")), hsa_ext_tools_event_wait_status_t, (Int32, hsa_ext_tools_event_t), timeout, event)
end

function ext_tools_destroy_event(event::hsa_ext_tools_event_t)
    ccall((:hsa_ext_tools_destroy_event, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_ext_tools_event_t,), event)
end

function ext_program_create(machine_model::hsa_machine_model_t, profile::hsa_profile_t, default_float_rounding_mode::hsa_default_float_rounding_mode_t, options, program::Ref{hsa_ext_program_t})
    ccall((:hsa_ext_program_create, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_machine_model_t, hsa_profile_t, hsa_default_float_rounding_mode_t, Cstring, Ref{hsa_ext_program_t}), machine_model, profile, default_float_rounding_mode, options, program)
end

function ext_program_destroy(program::hsa_ext_program_t)
    ccall((:hsa_ext_program_destroy, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_ext_program_t,), program)
end

function ext_program_add_module(program::hsa_ext_program_t, _module::hsa_ext_module_t)
    ccall((:hsa_ext_program_add_module, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_ext_program_t, hsa_ext_module_t), program, _module)
end

function ext_program_iterate_modules(program::hsa_ext_program_t, callback::Ref{Cvoid}, data::Ref{Cvoid})
    ccall((:hsa_ext_program_iterate_modules, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_ext_program_t, Ref{Cvoid}, Ref{Cvoid}), program, callback, data)
end

function ext_program_get_info(program::hsa_ext_program_t, attribute::hsa_ext_program_info_t, value::Ref{Cvoid})
    ccall((:hsa_ext_program_get_info, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_ext_program_t, hsa_ext_program_info_t, Ref{Cvoid}), program, attribute, value)
end

function ext_program_finalize(program::hsa_ext_program_t, isa::hsa_isa_t, call_convention::Int32, control_directives::hsa_ext_control_directives_t, options, code_object_type::hsa_code_object_type_t, code_object::Ref{hsa_code_object_t})
    ccall((:hsa_ext_program_finalize, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_ext_program_t, hsa_isa_t, Int32, hsa_ext_control_directives_t, Cstring, hsa_code_object_type_t, Ref{hsa_code_object_t}), program, isa, call_convention, control_directives, options, code_object_type, code_object)
end

function ven_amd_aqlprofile_version_major()
    ccall((:hsa_ven_amd_aqlprofile_version_major, Symbol("libhsa-runtime64")), UInt32, ())
end

function ven_amd_aqlprofile_version_minor()
    ccall((:hsa_ven_amd_aqlprofile_version_minor, Symbol("libhsa-runtime64")), UInt32, ())
end

function ven_amd_aqlprofile_validate_event(agent::hsa_agent_t, event::Ref{hsa_ven_amd_aqlprofile_event_t}, result::Ref{Bool})
    ccall((:hsa_ven_amd_aqlprofile_validate_event, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_agent_t, Ref{hsa_ven_amd_aqlprofile_event_t}, Ref{Bool}), agent, event, result)
end

function ven_amd_aqlprofile_start(profile::Ref{hsa_ven_amd_aqlprofile_profile_t}, aql_start_packet::Ref{hsa_ext_amd_aql_pm4_packet_t})
    ccall((:hsa_ven_amd_aqlprofile_start, Symbol("libhsa-runtime64")), hsa_status_t, (Ref{hsa_ven_amd_aqlprofile_profile_t}, Ref{hsa_ext_amd_aql_pm4_packet_t}), profile, aql_start_packet)
end

function ven_amd_aqlprofile_stop(profile::Ref{hsa_ven_amd_aqlprofile_profile_t}, aql_stop_packet::Ref{hsa_ext_amd_aql_pm4_packet_t})
    ccall((:hsa_ven_amd_aqlprofile_stop, Symbol("libhsa-runtime64")), hsa_status_t, (Ref{hsa_ven_amd_aqlprofile_profile_t}, Ref{hsa_ext_amd_aql_pm4_packet_t}), profile, aql_stop_packet)
end

function ven_amd_aqlprofile_read(profile::Ref{hsa_ven_amd_aqlprofile_profile_t}, aql_read_packet::Ref{hsa_ext_amd_aql_pm4_packet_t})
    ccall((:hsa_ven_amd_aqlprofile_read, Symbol("libhsa-runtime64")), hsa_status_t, (Ref{hsa_ven_amd_aqlprofile_profile_t}, Ref{hsa_ext_amd_aql_pm4_packet_t}), profile, aql_read_packet)
end

function ven_amd_aqlprofile_legacy_get_pm4(aql_packet::Ref{hsa_ext_amd_aql_pm4_packet_t}, data::Ref{Cvoid})
    ccall((:hsa_ven_amd_aqlprofile_legacy_get_pm4, Symbol("libhsa-runtime64")), hsa_status_t, (Ref{hsa_ext_amd_aql_pm4_packet_t}, Ref{Cvoid}), aql_packet, data)
end

function ven_amd_aqlprofile_get_info(profile::Ref{hsa_ven_amd_aqlprofile_profile_t}, attribute::hsa_ven_amd_aqlprofile_info_type_t, value::Ref{Cvoid})
    ccall((:hsa_ven_amd_aqlprofile_get_info, Symbol("libhsa-runtime64")), hsa_status_t, (Ref{hsa_ven_amd_aqlprofile_profile_t}, hsa_ven_amd_aqlprofile_info_type_t, Ref{Cvoid}), profile, attribute, value)
end

function ven_amd_aqlprofile_iterate_data(profile::Ref{hsa_ven_amd_aqlprofile_profile_t}, callback::hsa_ven_amd_aqlprofile_data_callback_t, data::Ref{Cvoid})
    ccall((:hsa_ven_amd_aqlprofile_iterate_data, Symbol("libhsa-runtime64")), hsa_status_t, (Ref{hsa_ven_amd_aqlprofile_profile_t}, hsa_ven_amd_aqlprofile_data_callback_t, Ref{Cvoid}), profile, callback, data)
end

function ven_amd_aqlprofile_error_string(str::Ref{Cstring})
    ccall((:hsa_ven_amd_aqlprofile_error_string, Symbol("libhsa-runtime64")), hsa_status_t, (Ref{Cstring},), str)
end

function ven_amd_loader_query_host_address(device_address::Ref{Cvoid}, host_address::Ref{Ptr{Cvoid}})
    ccall((:hsa_ven_amd_loader_query_host_address, Symbol("libhsa-runtime64")), hsa_status_t, (Ref{Cvoid}, Ref{Ptr{Cvoid}}), device_address, host_address)
end

function ven_amd_loader_query_segment_descriptors(segment_descriptors::Ref{hsa_ven_amd_loader_segment_descriptor_t}, num_segment_descriptors::Ref{Csize_t})
    ccall((:hsa_ven_amd_loader_query_segment_descriptors, Symbol("libhsa-runtime64")), hsa_status_t, (Ref{hsa_ven_amd_loader_segment_descriptor_t}, Ref{Csize_t}), segment_descriptors, num_segment_descriptors)
end

function ven_amd_loader_query_executable(device_address::Ref{Cvoid}, executable::Ref{hsa_executable_t})
    ccall((:hsa_ven_amd_loader_query_executable, Symbol("libhsa-runtime64")), hsa_status_t, (Ref{Cvoid}, Ref{hsa_executable_t}), device_address, executable)
end

function ven_amd_loader_executable_iterate_loaded_code_objects(executable::hsa_executable_t, callback::Ref{Cvoid}, data::Ref{Cvoid})
    ccall((:hsa_ven_amd_loader_executable_iterate_loaded_code_objects, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_executable_t, Ref{Cvoid}, Ref{Cvoid}), executable, callback, data)
end

function ven_amd_loader_loaded_code_object_get_info(loaded_code_object::hsa_loaded_code_object_t, attribute::hsa_ven_amd_loader_loaded_code_object_info_t, value::Ref{Cvoid})
    ccall((:hsa_ven_amd_loader_loaded_code_object_get_info, Symbol("libhsa-runtime64")), hsa_status_t, (hsa_loaded_code_object_t, hsa_ven_amd_loader_loaded_code_object_info_t, Ref{Cvoid}), loaded_code_object, attribute, value)
end
