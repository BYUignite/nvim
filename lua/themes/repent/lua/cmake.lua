local base = require('repent-base')
local c = require('repent-palette').c

local pkg = function()
    return {
        cmakeKWconfigure_package_config_file { base.Normal },
        cmakeKWwrite_basic_package_version_file { base.Normal },
        cmakeKWExternalProject { base.Normal },
        cmakeKWadd_compile_definitions { base.Normal },
        cmakeKWadd_compile_options { base.Normal },
        cmakeKWadd_custom_command { base.Normal },
        cmakeKWadd_custom_target { base.Normal },
        cmakeKWadd_definitions { base.Normal },
        cmakeKWadd_dependencies { base.Normal },
        cmakeKWadd_executable { base.Normal },
        cmakeKWadd_library { base.Normal },
        cmakeKWadd_link_options { base.Normal },
        cmakeKWadd_subdirectory { base.Normal },
        cmakeKWadd_test { base.Normal },
        cmakeKWbuild_command { base.Normal },
        cmakeKWcmake_host_system_information { base.Normal },
        cmakeKWcmake_minimum_required { base.Normal },
        cmakeKWcmake_parse_arguments { base.Normal },
        cmakeKWcmake_policy { base.Normal },
        cmakeKWconfigure_file { base.Normal },
        cmakeKWcreate_test_sourcelist { base.Normal },
        cmakeKWctest_build { base.Normal },
        cmakeKWctest_configure { base.Normal },
        cmakeKWctest_coverage { base.Normal },
        cmakeKWctest_memcheck { base.Normal },
        cmakeKWctest_run_script { base.Normal },
        cmakeKWctest_start { base.Normal },
        cmakeKWctest_submit { base.Normal },
        cmakeKWctest_test { base.Normal },
        cmakeKWctest_update { base.Normal },
        cmakeKWctest_upload { base.Normal },
        cmakeKWdefine_property { base.Normal },
        cmakeKWdoxygen_add_docs { base.Normal },
        cmakeKWenable_language { base.Normal },
        cmakeKWenable_testing { base.Normal },
        cmakeKWexec_program { base.Normal },
        cmakeKWexecute_process { base.Normal },
        cmakeKWexport { base.Normal },
        cmakeKWexport_library_dependencies { base.Normal },
        cmakeKWfile { base.Normal },
        cmakeKWfind_file { base.Normal },
        cmakeKWfind_library { base.Normal },
        cmakeKWfind_package { base.Normal },
        cmakeKWfind_path { base.Normal },
        cmakeKWfind_program { base.Normal },
        cmakeKWfltk_wrap_ui { base.Normal },
        cmakeKWforeach { base.Normal },
        cmakeKWfunction { base.Normal },
        cmakeKWget_cmake_property { base.Normal },
        cmakeKWget_directory_property { base.Normal },
        cmakeKWget_filename_component { base.Normal },
        cmakeKWget_property { base.Normal },
        cmakeKWget_source_file_property { base.Normal },
        cmakeKWget_target_property { base.Normal },
        cmakeKWget_test_property { base.Normal },
        cmakeKWif { base.Normal },
        cmakeKWinclude { base.Normal },
        cmakeKWinclude_directories { base.Normal },
        cmakeKWinclude_external_msproject { base.Normal },
        cmakeKWinclude_guard { base.Normal },
        cmakeKWinstall { base.Normal },
        cmakeKWinstall_files { base.Normal },
        cmakeKWinstall_programs { base.Normal },
        cmakeKWinstall_targets { base.Normal },
        cmakeKWlink_directories { base.Normal },
        cmakeKWlist { base.Normal },
        cmakeKWload_cache { base.Normal },
        cmakeKWload_command { base.Normal },
        cmakeKWmacro { base.Normal },
        cmakeKWmark_as_advanced { base.Normal },
        cmakeKWmath { base.Normal },
        cmakeKWmessage { base.Normal },
        cmakeKWoption { base.Normal },
        cmakeKWproject { base.Normal },
        cmakeKWqt_wrap_cpp { base.Normal },
        cmakeKWqt_wrap_ui { base.Normal },
        cmakeKWremove { base.Normal },
        cmakeKWseparate_arguments { base.Normal },
        cmakeKWset { base.Normal },
        cmakeKWset_directory_properties { base.Normal },
        cmakeKWset_property { base.Normal },
        cmakeKWset_source_files_properties { base.Normal },
        cmakeKWset_target_properties { base.Normal },
        cmakeKWset_tests_properties { base.Normal },
        cmakeKWsource_group { base.Normal },
        cmakeKWstring { base.Normal },
        cmakeKWsubdirs { base.Normal },
        cmakeKWtarget_compile_definitions { base.Normal },
        cmakeKWtarget_compile_features { base.Normal },
        cmakeKWtarget_compile_options { base.Normal },
        cmakeKWtarget_include_directories { base.Normal },
        cmakeKWtarget_link_directories { base.Normal },
        cmakeKWtarget_link_libraries { base.Normal },
        cmakeKWtarget_link_options { base.Normal },
        cmakeKWtarget_precompile_headers { base.Normal },
        cmakeKWtarget_sources { base.Normal },
        cmakeKWtry_compile { base.Normal },
        cmakeKWtry_run { base.Normal },
        cmakeKWunset { base.Normal },
        cmakeKWuse_mangled_mesa { base.Normal },
        cmakeKWvariable_requires { base.Normal },
        cmakeKWvariable_watch { base.Normal },
        cmakeKWwrite_file { base.Normal },
    }
end

return pkg  