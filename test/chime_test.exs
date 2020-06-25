defmodule ExAws.ChimeTest do
  use ExUnit.Case, async: true
  import Support.BypassHelpers

  alias ExAws.Chime
  setup [:start_bypass]

  test "create meeting", %{bypass: bypass} do
    id = UUID.uuid4()

    meeting = %{
      "ExternalMeetingId" => "test_id",
      "MediaPlacement" => %{
        "AudioFallbackUrl" => "wss://haxrp.m2.ue2.app.chime.aws:443/calls/#{id}",
        "AudioHostUrl" => "#{UUID.uuid4()}.k.m2.ue2.app.chime.aws:3478",
        "ScreenDataUrl" => "wss://bitpw.m2.ue2.app.chime.aws:443/v2/screen/#{id}",
        "ScreenSharingUrl" => "wss://bitpw.m2.ue2.app.chime.aws:443/v2/screen/#{id}",
        "ScreenViewingUrl" =>
          "wss://bitpw.m2.ue2.app.chime.aws:443/ws/connect?passcode=null&viewer_uuid=null&X-BitHub-Call-Id=#{
            id
          }",
        "SignalingUrl" => "wss://signal.m2.ue2.app.chime.aws/control/#{id}",
        "TurnControlUrl" => "https://ccp.cp.ue1.app.chime.aws/v2/turn_sessions"
      },
      "MediaRegion" => "us-east-2",
      "MeetingId" => id
    }

    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 201, Jason.encode!(%{"Meeting" => meeting}))
    end)

    assert {:ok, %{"Meeting" => ^meeting}} =
             Chime.create_meeting(%{
               "ClientRequestToken" => "client_token_foo",
               "ExternalMeetingId" => "test_id",
               "MediaRegion" => "us-east-2",
               "MeetingHostId" => "bar.localhost"
             })
             |> ExAws.request(exaws_config_for_bypass(bypass))
  end

  test "delete meeting", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 204, "")
    end)

    assert {:ok, %{}} =
             Chime.delete_meeting(UUID.uuid4())
             |> ExAws.request(exaws_config_for_bypass(bypass))
  end

  test "create attendee", %{bypass: bypass} do
    attendee_id = UUID.uuid4()

    attendee = %{
      "AttendeeId" => attendee_id,
      "ExternalUserId" => "test-user-id-2",
      "JoinToken" =>
        "NWNhMzVhNWQtMTJjZC00MWNiLWJlYTItYzc5ZmEwZGU5MjQ0OmJjYmQzMzhlLWI0ZjYtNDFlYS1iOTJmLTlmNzFlNTBmOTliMg",
      "Tags" => nil
    }

    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 201, Jason.encode!(%{"Attendee" => attendee}))
    end)

    assert {:ok, %{"Attendee" => ^attendee}} =
             Chime.create_attendee(UUID.uuid4(), %{"ExternalUserId" => attendee_id})
             |> ExAws.request(exaws_config_for_bypass(bypass))
  end
end
