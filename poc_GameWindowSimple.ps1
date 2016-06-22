# Joel Roth 2016

# Ported from OpenTK sample "GameWindowSimple" (Tutorial #0)
# https://github.com/opentk/opentk/blob/master/Source/Examples/OpenTK/GameWindow/GameWindowSimple.cs

Remove-Variable * -ErrorAction SilentlyContinue
$DebugPreference = "Continue"

[Reflection.Assembly]::LoadFile("\\path\to\OpenTK.dll")
[Reflection.Assembly]::LoadFile("\\path\to\OpenTK.GLControl.dll")

$window = [OpenTK.GameWindow]::New()
$window = New-Object OpenTK.GameWindow
$window.Title = "OpenGL Window"
$gl = [OpenTK.Graphics.OpenGL.GL]

$window.add_Load({ 
    $window.VSync = [OpenTK.VSyncMode]::On 
    $gl::ClearColor([System.Drawing.Color]::Azure)
})
$window.add_Resize({ $gl::Viewport(0, 0, $window.Width, $window.Height); })
#Deprecated, use KeyDown event handler instead
<#
$window.add_UpdateFrame({
    if ([OpenTK.Input.Keyboard]::GetState().IsKeyDown([OpenTK.Input.Key]::Escape)) { 
        $window.Close() 
    }
})
#>
$window.add_KeyDown({
    if ($_.Key -eq [OpenTK.Input.Key]::Escape) {
        $window.Close() 
    }
    elseif ($_.Key -eq [OpenTK.Input.Key]::Space) {
        Write-Debug "Space"
    }
})
$window.add_RenderFrame({
    $gl::Clear([OpenTK.Graphics.OpenGL.ClearBufferMask]::ColorBufferBit)
    $gl::Clear([OpenTK.Graphics.OpenGL.ClearBufferMask]::DepthBufferBit)
    
    $gl::MatrixMode([OpenTK.Graphics.OpenGL.MatrixMode]::Projection)
    $gl::LoadIdentity()
    $gl::Ortho(-1.0, 1.0, -1.0, 1.0, 0.0, 4.0)

    $gl::Begin([OpenTK.Graphics.OpenGL.PrimitiveType]::Triangles)

    $gl::Color3([System.Drawing.Color]::MidnightBlue)
    $gl::Vertex2(-1.0,1.0)
    $gl::Color3([System.Drawing.Color]::SpringGreen)
    $gl::Vertex2(0.0,-1.0)
    $gl::Color3([System.Drawing.Color]::Ivory)
    $gl::Vertex2(1.0,1.0)
    
    $gl::End()

    $window.SwapBuffers()
})

$window.Run(60)
