defmodule ExAws.Chime do
  @moduledoc """
  Basic operations on AWS Chime
  """
  @doc """
  Create new meeting

  ## Examples
  ```
  Chime.create_meeting(%{
    "ClientRequestToken" => "client_token_foo",
    "ExternalMeetingId" => "test_id",
    "MediaRegion" => "us-east-2",
    "MeetingHostId" => "bar.localhost"
  })

  {:ok,
  %{
   "Meeting" => %{
     "ExternalMeetingId" => "test_id",
     "MediaPlacement" => %{
       "AudioFallbackUrl" => "wss://haxrp.m1.ue2.app.chime.aws:443/calls/11111111-9ae4-4f07-8ced-a7b0016b3339",
       "AudioHostUrl" => "c00000000e8df2fe0fd97e91dce65b04.k.m1.ue2.app.chime.aws:3478",
       "ScreenDataUrl" => "wss://bitpw.m1.ue2.app.chime.aws:443/v2/screen/11111111-9ae4-4f07-8ced-a7b0016b3339",
       "ScreenSharingUrl" => "wss://bitpw.m1.ue2.app.chime.aws:443/v2/screen/11111111-9ae4-4f07-8ced-a7b0016b3339",
       "ScreenViewingUrl" => "wss://bitpw.m1.ue2.app.chime.aws:443/ws/connect?passcode=null&viewer_uuid=null&X-BitHub-Call-Id=11111111-9ae4-4f07-8ced-a7b0016b3339",
       "SignalingUrl" => "wss://signal.m1.ue2.app.chime.aws/control/11111111-9ae4-4f07-8ced-a7b0016b3339",
       "TurnControlUrl" => "https://ccp.cp.ue1.app.chime.aws/v2/turn_sessions"
     },
     "MediaRegion" => "us-east-2",
     "MeetingId" => "11111111-9ae4-4f07-8ced-a7b0016b3339"
   }
  }}
  ```
  """
  def create_meeting(data) do
    %ExAws.Operation.JSON{
      service: :chime,
      http_method: :post,
      path: "/meetings",
      data: data
    }
    |> ExAws.request()
  end

  @doc """
  Delete meeting

  ## Examples
  ```
  Chime.delete_meeting("1f30c754-b7b4-4880-866a-dc9f8e4fc7c7")

  {:ok, %{}}
  ```
  """
  def delete_meeting(meeting_id) do
    %ExAws.Operation.JSON{
      service: :chime,
      http_method: :delete,
      path: "/meetings/#{meeting_id}"
    }
    |> ExAws.request()
  end

  @doc """
  Create new attendee

  ## Examples
  ```
  Chime.create_attendee("1f72816b-e591-46fd-a95a-a9ce98e9a840", %{"ExternalUserId" => "test-user-id-2"})

  {:ok,
  %{
   "Attendee" => %{
     "AttendeeId" => "5ca35a5d-12cd-41cb-bea2-c79fa0de9244",
     "ExternalUserId" => "test-user-id-2",
     "JoinToken" => "NWNhMzVhNWQtMTJjZC00MWNiLWJlYTItYzc5ZmEwZGU5MjQ0OmJjYmQzMzhlLWI0ZjYtNDFlYS1iOTJmLTlmNzFlNTBmOTliMg",
     "Tags" => nil
   }
  }}
  ```
  """
  def create_attendee(meeting_id, data) do
    %ExAws.Operation.JSON{
      service: :chime,
      http_method: :post,
      path: "/meetings/#{meeting_id}/attendees",
      data: data
    }
    |> ExAws.request()
  end
end
