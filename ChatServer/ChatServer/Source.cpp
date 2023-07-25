#include <winsock.h>
#include <iostream>
#include <vector>

#pragma comment(lib, "ws2_32.lib")
#pragma warning(disable: 4996)
#define _WINSOCK_DEPRECATED_NO_WARNINGS

using namespace std;

SOCKET connections[100];
int counter = 0;
int as;

std::vector<std::string> splitString(std::string str, char splitter) {
	std::vector<std::string> result;
	std::string current = "";
	for (int i = 0; i < str.size(); i++) {
		if (str[i] == splitter) {
			if (current != "") {
				result.push_back(current);
				current = "";
			}
			continue;
		}
		current += str[i];
	}
	if (current.size() != 0)
		result.push_back(current);
	return result;
}

class per
{
public:
	SOCKET newCom;
	int index;
};

char msg[256];

void ClientHandler(per per)
{
	int id = NULL;
	int sendid = NULL;

	while (id == NULL)
	{
		as = recv(per.newCom, msg, sizeof(msg), NULL);
		vector<string> strings = splitString(msg, '-');
		if (as <= 0)
		{
			if (WSAGetLastError() != WSAEWOULDBLOCK)
			{
				closesocket(connections[per.index]);
				connections[per.index] = NULL;
				counter--;
				cout << "All: " << counter;
				return;

			}
		}
		id = atoi(strings[0].c_str());
	}
	cout << id << endl;
	connections[id] = per.newCom;

	int msg_size;
	while (true && id != NULL)
	{
		
				as = recv(connections[id], (char*)&msg_size, sizeof(int), NULL);
				char* zxx = new char[msg_size + 1];
				zxx[msg_size] = '\0';
				as = recv(connections[id], zxx, msg_size, NULL);
				vector<string> strings = splitString(zxx, '-');
				if (as <= 0)
				{
					if (WSAGetLastError() != WSAEWOULDBLOCK)
					{
						closesocket(connections[sendid]);
						connections[sendid] = NULL;
						counter--;
						cout << "All: " << counter;
						return;

					}
				}
				send(connections[atoi(strings[1].c_str())], (char*)&id, sizeof(int), NULL);
				send(connections[atoi(strings[1].c_str())], (char*)&msg_size, sizeof(int), NULL);
				send(connections[atoi(strings[1].c_str())], zxx, msg_size, NULL);
				cout << "Size: " << msg_size << " String: " << zxx << endl;
				delete[] zxx;
	}
}

int main()
{
	WSAData wsaData;
	WORD DLLVersion = MAKEWORD(2, 1);
	if (WSAStartup(DLLVersion, &wsaData) != 0)
	{
		cout << "ERROR";
		exit(1);
	}

	SOCKADDR_IN addr;
	int sizeoffaddr = sizeof(addr);
	addr.sin_addr.s_addr = inet_addr("192.168.0.189");
	addr.sin_port = htons(25565);
	addr.sin_family = AF_INET;

	SOCKET sListen = socket(AF_INET, SOCK_STREAM, NULL);
	bind(sListen, (SOCKADDR*)&addr, sizeof(addr));
	listen(sListen, SOMAXCONN);

	SOCKET newCon;
	for (int i = 0; i < 100; i++)
	{
		newCon = accept(sListen, (SOCKADDR*)&addr, &sizeoffaddr);

		if (newCon == 0)
		{
			cout << "Error #2";
			return 1;
		}

		cout << "Client connected!" << endl;

		per per;
		per.index = i;
		per.newCom = newCon;

		CreateThread(NULL, NULL, (LPTHREAD_START_ROUTINE)ClientHandler, &per, NULL, NULL);
		counter++;
		cout << "All: " << counter << endl;
	}

	return 0;
}