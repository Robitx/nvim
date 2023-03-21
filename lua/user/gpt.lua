local status_ok, gpt = pcall(require, "gpt")
if not status_ok then
	return
end

gpt.setup({
    api_key = "xxx"
    -- You could read it from environment variable like this
    -- or just run empty setup since plugin reads this env by default
    -- api_key = os.getenv("OPENAI_API_KEY")
})

local T = {}
T.code_start = "I have the following {{language}} code:\n\n```{{filetype}}\n{{text_selection}}```\n\n"
T.code_end = "\n\nRespond with the final code snippet and nothing else."
T.system_template = "You are a general AI assistant to a software developer."

local M = {}

M.replace = function()
    gpt.replace(
        "gpt cmd ~ ",
        T.code_start .. "{{command_args}}." .. T.code_end,
        T.system_template)
end

M.visual_prompt_inline = function()
    gpt.visual_prompt_inline(
        "gpt cmd ~ ",
        T.code_start .. "{{command_args}}.",
        T.system_template)
end

M.visual_prompt_popup = function()
    gpt.visual_prompt_popup(
        "gpt cmd ~ ",
        T.code_start .. "{{command_args}}.",
        T.system_template)
end

M.visual_prompt_enew = function()
    gpt.visual_prompt_enew(
        "gpt cmd ~ ",
        T.code_start .. "{{command_args}}.",
        T.system_template)
end


M.prompt_inline = function()
    gpt.prompt_inline(
        "gpt cmd ~ ",
        "{{command_args}}.",
        T.system_template)
end

M.prompt_popup = function()
    gpt.prompt_popup(
        "gpt cmd ~ ",
        "{{command_args}}.",
        T.system_template)
end


M.prompt_enew = function()
    gpt.prompt_enew(
        "gpt cmd ~ ",
        "{{command_args}}.",
        T.system_template)
end

return M
